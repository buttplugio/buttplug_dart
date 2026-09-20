import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:buttplug/buttplug.dart';
import 'package:test/test.dart';

void main() {
  test('sorter accepts early replies and ignores duplicate/unknown replies', () async {
    final sorter = MessageSorter();
    final request = RequestDeviceList();
    sorter.prepareMessage(request);
    final response = ButtplugServerMessage()..deviceList = (DeviceList()..id = request.id);
    sorter.checkMessage(response);
    sorter.checkMessage(response);
    sorter.checkMessage(ButtplugServerMessage()..ok = (Ok()..id = 999));
    expect(await sorter.waitForMessage(request.id), same(response));
    await expectLater(sorter.waitForMessage(request.id), throwsA(isA<ButtplugMessageException>()));
  });

  for (final throwAt in [1, 2]) {
    test('send failure on message $throwAt rejects observed batch', () async {
      final connector = LifecycleConnector()..throwAt = throwAt;
      final communicator = ButtplugClientCommunicator(connector);
      await communicator.connect();
      await expectLater(
        communicator.sendMessagesExpectReply([RequestDeviceList(), StartScanning(), StopScanning()]),
        throwsA(isA<StateError>()),
      );
      expect(communicator.connected(), isFalse);
      await communicator.disconnect();
    });
  }

  test('transport closure while connect awaits cannot mark connected', () async {
    final connector = LifecycleConnector()..gate = Completer<void>();
    final communicator = ButtplugClientCommunicator(connector);
    final result = expectLater(communicator.connect(), throwsA(isA<ButtplugClientException>()));
    await connector.entered.future;
    await connector.closeStream();
    connector.gate!.complete();
    await result;
    expect(communicator.connected(), isFalse);
    await communicator.disconnect();
  });

  test('disconnect failure still cancels communicator subscription', () async {
    final connector = LifecycleConnector()..throwOnDisconnect = true;
    final communicator = ButtplugClientCommunicator(connector);
    await communicator.connect();
    expect(connector._controller.hasListener, isTrue);
    await expectLater(communicator.disconnect(), throwsA(isA<StateError>()));
    expect(connector._controller.hasListener, isFalse);
    expect(communicator.connected(), isFalse);
    await connector.closeStream();
  });

  test('immediate disconnect cancels client setup before transport connect', () async {
    final connector = LifecycleConnector();
    final client = ButtplugClient('test');
    final result = expectLater(client.connect(connector), throwsA(isA<ButtplugClientException>()));
    await client.disconnect();
    await result;
    expect(connector.entered.isCompleted, isFalse);
    expect(connector._controller.hasListener, isFalse);
    expect(client.connected(), isFalse);
  });

  test('concurrent client connect is rejected during transport setup', () async {
    final connector = LifecycleConnector()..gate = Completer<void>();
    final client = ButtplugClient('test');
    final result = expectLater(client.connect(connector), throwsA(anything));
    await connector.entered.future;
    await expectLater(client.connect(LifecycleConnector()), throwsA(isA<ButtplugClientException>()));
    await connector.closeStream();
    connector.gate!.complete();
    await result;
    expect(client.connected(), isFalse);
  });

  for (final malformed in [false, true]) {
    test('real websocket ${malformed ? 'malformed payload' : 'remote close'} rejects pending command once', () async {
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      final peer = Completer<WebSocket>();
      final command = Completer<void>();
      final listener = server.listen((request) async {
        final socket = await WebSocketTransformer.upgrade(request);
        peer.complete(socket);
        socket.listen((data) {
          final message = (jsonDecode(data as String) as List).single as Map<String, dynamic>;
          final type = message.keys.single;
          final id = (message[type] as Map<String, dynamic>)['Id'];
          if (type == 'RequestServerInfo') {
            socket.add(jsonEncode([{'ServerInfo': {'Id': id, 'ServerName': 'test', 'ProtocolVersionMajor': 4, 'ProtocolVersionMinor': 0, 'MaxPingTime': 0}}]));
          } else if (type == 'RequestDeviceList') {
            socket.add(jsonEncode([{'DeviceList': {'Id': id, 'Devices': {'0': {'DeviceIndex': 0, 'DeviceName': 'test device', 'DeviceFeatures': <String, dynamic>{}}}}}]));
          } else {
            if (!command.isCompleted) command.complete();
          }
        });
      });
      final connector = ButtplugWebsocketClientConnector('ws://127.0.0.1:${server.port}');
      final client = ButtplugClient('test');
      final connecting = client.connect(connector);
      final events = <ButtplugClientEvent>[];
      final disconnected = Completer<void>();
      final subscription = client.eventStream.listen((event) {
        events.add(event);
        if (event is DisconnectEvent && !disconnected.isCompleted) disconnected.complete();
      });
      try {
        await connecting.timeout(const Duration(seconds: 5));
        final pending = expectLater(client.startScanning(), throwsA(isA<ButtplugClientException>()));
        await command.future.timeout(const Duration(seconds: 5));
        expect(events.whereType<DeviceListReceivedEvent>(), hasLength(1));
        expect(events.whereType<DeviceAddedEvent>().single.device, same(client.devices[0]));
        final socket = await peer.future;
        if (malformed) {
          socket.add('not json');
        } else {
          await socket.close();
        }
        await pending.timeout(const Duration(seconds: 5));
        await disconnected.future.timeout(const Duration(seconds: 5));
        await client.disconnect();
        expect(client.connected(), isFalse);
        expect(events.whereType<DisconnectEvent>(), hasLength(1));
      } finally {
        await client.disconnect();
        await subscription.cancel();
        if (peer.isCompleted) await (await peer.future).close();
        await listener.cancel();
        await server.close(force: true);
      }
    });
  }

  test('failed websocket connect closes message stream and rejects connect', () async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final listener = server.listen((request) async {
      request.response.statusCode = HttpStatus.forbidden;
      await request.response.close();
    });
    final connector = ButtplugWebsocketClientConnector('ws://127.0.0.1:${server.port}');
    final done = connector.messageStream.drain<void>();
    try {
      await expectLater(connector.connect(), throwsA(anything)).timeout(const Duration(seconds: 5));
      await done.timeout(const Duration(seconds: 5));
    } finally {
      await connector.disconnect();
      await listener.cancel();
      await server.close(force: true);
    }
  });
}

class LifecycleConnector implements ButtplugClientConnector {
  final StreamController<ButtplugServerMessage> _controller = StreamController.broadcast();
  final entered = Completer<void>();
  Completer<void>? gate;
  int? throwAt;
  int sends = 0;
  bool throwOnDisconnect = false;

  @override
  Future<void> connect() async {
    entered.complete();
    await gate?.future;
  }

  @override
  Future<void> disconnect() async {
    if (throwOnDisconnect) throw StateError('disconnect failed');
    await closeStream();
  }

  @override
  void send(List<ButtplugClientMessageUnion> messages) {
    sends++;
    if (sends == throwAt) throw StateError('send failed');
  }

  @override
  Stream<ButtplugServerMessage> get messageStream => _controller.stream;

  Future<void> closeStream() async {
    if (!_controller.isClosed) await _controller.close();
  }
}
