import 'dart:async';
import 'dart:convert';

import 'package:buttplug/buttplug.dart';
import 'package:test/test.dart';

void main() {
  group('Message de/serialization', () {
    setUp(() {
      // Additional setup goes here.
    });

    /*
    test('Message Union Formatting', () {
      var ok = Ok();
      ok.id = 5;
      var serverOk = ButtplugServerMessage();
      serverOk.ok = ok;
      var jsonString = jsonEncode(serverOk);
      expect(jsonString, equals('{"Ok":{"Id":5}}'));
    });
*/
    test('Device List Deserialization', () {
      var incoming =
          '[{"DeviceList":{"Id":2,"Devices":{"0":{"DeviceIndex":0,"DeviceName":"Lovense Ridge","DeviceMessageTimingGap":100,"DeviceFeatures":{"0":{"FeatureIndex":0,"FeatureDescription":"","Output":{"Vibrate":{"Value":[0,20]}}},"1":{"FeatureIndex":1,"FeatureDescription":"","Output":{"Rotate":{"Value":[-20,20]}}},"2":{"FeatureIndex":2,"FeatureDescription":"battery Level","Input":{"Battery":{"ValueRange":[[0,100]],"InputCommands":["Read"]}}}}}}}}]';
      List<dynamic> messageList = jsonDecode(incoming);
      var message = ButtplugServerMessage.fromJson(messageList[0]);
      expect(message.deviceList, isNotNull);
      var deviceAdded = message.deviceList!.devices[0]!;
      expect(deviceAdded.deviceName, equals("Lovense Ridge"));
    });
    /*
    test('Handle deserializing list of Buttplug Server Messages', () {
      var incoming = '[{"Ok": {"Id":5}}]';
      List<dynamic> msgs = jsonDecode(incoming);
      for (var msg in msgs) {
        var message = ButtplugServerMessage.fromJson(msg);
        expect(message.ok, isNotNull);
        expect(message.ok!.id, equals(5));
      }
    });
      */
  });

  group('Client Disconnection and Events', () {
    test('Connector stores the correct address', () {
      final connector = ButtplugWebsocketClientConnector('ws://127.0.0.1:54321');
      expect(connector.address, equals('ws://127.0.0.1:54321'));
    });

    test('Client triggers DisconnectEvent on stream close', () async {
      final client = ButtplugClient('Test Client');
      final connector = MockConnector();

      // Start connection in background
      final connectFuture = client.connect(connector);

      // Wait a microtask for the client to send RequestServerInfo
      await Future.delayed(Duration(milliseconds: 10));

      // Simulate handshake server messages:
      // 1. ServerInfo (matching the request ID)
      final serverInfo = ButtplugServerMessage()
        ..serverInfo = (ServerInfo()
          ..id = connector.lastMessageId
          ..serverName = 'Test Server'
          ..protocolVersionMajor = 4
          ..protocolVersionMinor = 0);
      connector.simulateServerMessage(serverInfo);

      // Wait a microtask for the client to send RequestDeviceList
      await Future.delayed(Duration(milliseconds: 10));

      // 2. DeviceList (matching the request ID)
      final deviceList = ButtplugServerMessage()
        ..deviceList = (DeviceList()
          ..id = connector.lastMessageId
          ..devices = {});
      connector.simulateServerMessage(deviceList);

      await connectFuture;

      expect(client.connected(), isTrue);

      // Listen for DisconnectEvent
      ButtplugClientEvent? receivedEvent;
      client.eventStream.listen((event) {
        receivedEvent = event;
      });

      // Simulate connection drop
      connector.simulateDisconnect();

      // Wait a microtask to let the stream events propagate
      await Future.delayed(Duration(milliseconds: 10));

      expect(client.connected(), isFalse);
      expect(receivedEvent, isA<DisconnectEvent>());
    });
  });
}

class MockConnector implements ButtplugClientConnector {
  final StreamController<ButtplugServerMessage> _messageStreamController = StreamController.broadcast();
  int lastMessageId = 0;
  bool isConnected = false;

  @override
  Future<void> connect() async {
    isConnected = true;
  }

  @override
  Future<void> disconnect() async {
    isConnected = false;
    await _messageStreamController.close();
  }

  @override
  void send(List<ButtplugClientMessageUnion> messages) {
    if (messages.isNotEmpty) {
      lastMessageId = messages[0].id;
    }
  }

  @override
  Stream<ButtplugServerMessage> get messageStream => _messageStreamController.stream;

  void simulateServerMessage(ButtplugServerMessage message) {
    _messageStreamController.add(message);
  }

  void simulateDisconnect() {
    _messageStreamController.close();
  }
}
