import 'dart:async';
import 'dart:convert';

import 'package:buttplug/buttplug.dart';
import 'package:test/test.dart';

void main() {
  group('Message de/serialization', () {
    test('Message Union Formatting', () {
      var ok = Ok()..id = 5;
      var serverOk = ButtplugServerMessage()..ok = ok;
      var jsonString = jsonEncode(serverOk);
      expect(jsonString, equals('{"Ok":{"Id":5}}'));
    });

    test('Device List Deserialization', () {
      var incoming =
          '[{"DeviceList":{"Id":2,"Devices":{"0":{"DeviceIndex":0,"DeviceName":"Lovense Ridge","DeviceMessageTimingGap":100,"DeviceFeatures":{"0":{"FeatureIndex":0,"FeatureDescription":"","Output":{"Vibrate":{"Value":[0,20]}}},"1":{"FeatureIndex":1,"FeatureDescription":"","Output":{"Rotate":{"Value":[-20,20]}}},"2":{"FeatureIndex":2,"FeatureDescription":"battery Level","Input":{"Battery":{"Value":[[0,100]],"Command":["Read"]}}}}}}}}]';
      List<dynamic> messageList = jsonDecode(incoming);
      var message = ButtplugServerMessage.fromJson(messageList[0]);
      expect(message.deviceList, isNotNull);
      var deviceAdded = message.deviceList!.devices[0]!;
      expect(deviceAdded.deviceName, equals('Lovense Ridge'));
    });

    test('Handle deserializing list of Buttplug Server Messages', () {
      var incoming = '[{"Ok": {"Id":5}}]';
      List<dynamic> msgs = jsonDecode(incoming);
      for (var msg in msgs) {
        var message = ButtplugServerMessage.fromJson(msg);
        expect(message.ok, isNotNull);
        expect(message.ok!.id, equals(5));
      }
    });
  });

  group('Client Disconnection and Events', () {
    test('Connector stores the correct address', () {
      final connector = ButtplugWebsocketClientConnector('ws://127.0.0.1:54321');
      expect(connector.address, equals('ws://127.0.0.1:54321'));
    });

    test('Client triggers DisconnectEvent on stream close', () async {
      final client = ButtplugClient('Test Client');
      final connector = MockConnector();

      final connectFuture = client.connect(connector);

      // Respond to the handshake requests only after the client has sent them.
      await connector.sentMessageIds.first;
      final serverInfo = ButtplugServerMessage()
        ..serverInfo = (ServerInfo()
          ..id = connector.lastMessageId
          ..serverName = 'Test Server'
          ..protocolVersionMajor = 4
          ..protocolVersionMinor = 0);
      connector.simulateServerMessage(serverInfo);

      await connector.sentMessageIds.first;
      final deviceList = ButtplugServerMessage()
        ..deviceList = (DeviceList()
          ..id = connector.lastMessageId
          ..devices = {});
      connector.simulateServerMessage(deviceList);

      await connectFuture;
      expect(client.connected(), isTrue);

      final disconnectFuture = client.eventStream.firstWhere(
        (event) => event is DisconnectEvent,
      );
      connector.simulateDisconnect();
      await disconnectFuture;

      expect(client.connected(), isFalse);
    });
  });
}

class MockConnector implements ButtplugClientConnector {
  final StreamController<ButtplugServerMessage> _messageStreamController =
      StreamController.broadcast();
  final StreamController<int> _sentMessageController =
      StreamController.broadcast();
  int lastMessageId = 0;
  bool isConnected = false;

  Stream<int> get sentMessageIds => _sentMessageController.stream;

  @override
  Future<void> connect() async {
    isConnected = true;
  }

  @override
  Future<void> disconnect() async {
    isConnected = false;
    await _messageStreamController.close();
    await _sentMessageController.close();
  }

  @override
  void send(List<ButtplugClientMessageUnion> messages) {
    if (messages.isNotEmpty) {
      lastMessageId = messages[0].id;
      _sentMessageController.add(lastMessageId);
    }
  }

  @override
  Stream<ButtplugServerMessage> get messageStream =>
      _messageStreamController.stream;

  void simulateServerMessage(ButtplugServerMessage message) {
    _messageStreamController.add(message);
  }

  void simulateDisconnect() {
    _messageStreamController.close();
  }
}
