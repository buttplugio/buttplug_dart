import 'dart:async';

import 'package:buttplug/client/client_device.dart';
import 'package:buttplug/client/sorter.dart';
import 'package:buttplug/connectors/connector.dart';
import 'package:buttplug/messages/messages.dart';

class ButtplugClientException implements Exception {
  final String message;
  ButtplugClientException(this.message);
}

class ButtplugClientEvent {}

class DeviceAddedEvent extends ButtplugClientEvent {
  final ButtplugClientDevice device;

  DeviceAddedEvent(this.device);
}

class DeviceRemovedEvent extends ButtplugClientEvent {
  final ButtplugClientDevice device;

  DeviceRemovedEvent(this.device);
}

class ButtplugClient {
  final String name;
  String? _serverName;
  StreamController<ButtplugClientEvent> _eventStream = StreamController();
  ButtplugClientConnector? _connector;
  final MessageSorter _sorter = MessageSorter();
  final Map<int, ButtplugClientDevice> _devices = {};

  ButtplugClient(this.name);

  Future<void> connect(ButtplugClientConnector connector) async {
    _connector = connector;
    _connector!.messageStream.listen((message) {
      if (message.id != 0) {
        _sorter.checkMessage(message);
        return;
      }
      if (message.deviceAdded != null) {
        var device = ButtplugClientDevice(message.deviceAdded!, (msg) => _sendMessageExpectReply(msg));
        _devices[device.index] = device;
        _eventStream.add(DeviceAddedEvent(device));
      }
      if (message.deviceRemoved != null) {
        var device = _devices[message.deviceRemoved!.deviceIndex]!;
        _devices.remove(message.deviceRemoved!.deviceIndex);
        _eventStream.add(DeviceRemovedEvent(device));
      }
    });
    await _connector!.connect();
    await _runHandshake();
  }

  bool connected() {
    return true;
  }

  Future<void> disconnect() async {
    await _connector!.disconnect();
  }

  Future<void> _runHandshake() async {
    // Send RequestServerInfo, expect back ServerInfo
    var requestServerInfo = RequestServerInfo();
    requestServerInfo.clientName = name;
    _sorter.prepareMessage(requestServerInfo);
    _connector!.send(requestServerInfo.asClientMessageUnion());
    ButtplugServerMessage serverInfo = await _sorter.waitForMessage(requestServerInfo.id);
    if (serverInfo.serverInfo == null) {
      throw ButtplugClientException("Did not receive ServerInfo message back from server on handshake.");
    }
    _serverName = serverInfo.serverInfo!.serverName;

    // Send RequestDeviceList, expect back DeviceList
    var requestDeviceList = RequestDeviceList();
    _sorter.prepareMessage(requestDeviceList);
    _connector!.send(requestDeviceList.asClientMessageUnion());
    ButtplugServerMessage deviceListWrapper = await _sorter.waitForMessage(requestDeviceList.id);
    if (deviceListWrapper.deviceList == null) {
      throw ButtplugClientException("Did not receive DeviceList message back from server on handshake.");
    }
    var deviceList = deviceListWrapper.deviceList!;
    for (var device in deviceList.devices) {
      _devices[device.deviceIndex] = ButtplugClientDevice(device, _sendMessageExpectReply);
    }
  }

  Future<ButtplugServerMessage> _sendMessageExpectReply(ButtplugClientMessage message) async {
    _sorter.prepareMessage(message);
    _connector!.send(message.asClientMessageUnion());
    return await _sorter.waitForMessage(message.id);
  }

  Future<void> _sendMessageExpectOk(ButtplugClientMessage message) async {
    ButtplugServerMessage okWrapper = await _sendMessageExpectReply(message);
    if (okWrapper.ok == null) {
      throw ButtplugClientException("Did not receive DeviceList message back from server on handshake.");
    }
  }

  Future<void> startScanning() async {
    await _sendMessageExpectOk(StartScanning());
  }

  Future<void> stopScanning() async {
    await _sendMessageExpectOk(StopScanning());
  }

  Future<void> stopAllDevices() async {
    await _sendMessageExpectOk(StopAllDevices());
  }

  Future<void> _parseMessage() async {}

  String? get serverName => _serverName;
  Map<int, ButtplugClientDevice> get devices => _devices;
  Stream<ButtplugClientEvent> get eventStream => _eventStream.stream;
}
