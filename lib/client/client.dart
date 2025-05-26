part of '../buttplug.dart';

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
  _ButtplugClientCommunicator? _communicator;
  final Map<int, ButtplugClientDevice> _devices = {};

  ButtplugClient(this.name);

  Future<void> connect(ButtplugClientConnector connector) async {
    _communicator = _ButtplugClientCommunicator(connector);
    connector.messageStream.listen((message) {
      if (message.deviceAdded != null) {
        var device = ButtplugClientDevice._(message.deviceAdded!, _communicator!);
        _devices[device.index] = device;
        _communicator!.eventStreamController.add(DeviceAddedEvent(device));
      }
      if (message.deviceRemoved != null) {
        var device = _devices[message.deviceRemoved!.deviceIndex]!;
        _devices.remove(message.deviceRemoved!.deviceIndex);
        _communicator!.eventStreamController.add(DeviceRemovedEvent(device));
      }
    });

    await _communicator!.connect();

    // Send RequestServerInfo, expect back ServerInfo
    var requestServerInfo = RequestServerInfo();
    requestServerInfo.clientName = name;
    ButtplugServerMessage serverInfo = await _communicator!.sendMessageExpectReply(requestServerInfo);
    if (serverInfo.serverInfo == null) {
      throw ButtplugClientException(
          "Did not receive ServerInfo message back from server on handshake: ${jsonEncode(serverInfo.toJson())}.");
    }
    _serverName = serverInfo.serverInfo!.serverName;

    // Send RequestDeviceList, expect back DeviceList
    var requestDeviceList = RequestDeviceList();
    ButtplugServerMessage deviceListWrapper = await _communicator!.sendMessageExpectReply(requestDeviceList);
    if (deviceListWrapper.deviceList == null) {
      throw ButtplugClientException("Did not receive DeviceList message back from server on handshake.");
    }
    var deviceList = deviceListWrapper.deviceList!;
    for (var device in deviceList.devices) {
      _devices[device.deviceIndex] = ButtplugClientDevice._(device, _communicator!);
    }
  }

  bool connected() {
    return true;
  }

  Future<void> disconnect() async {
    await _communicator!.disconnect();
  }

  Future<void> startScanning() async {
    await _communicator!.sendMessageExpectOk(StartScanning());
  }

  Future<void> stopScanning() async {
    await _communicator!.sendMessageExpectOk(StopScanning());
  }

  Future<void> stopAllDevices() async {
    await _communicator!.sendMessageExpectOk(StopAllDevices());
  }

  String? get serverName => _serverName;
  Map<int, ButtplugClientDevice> get devices => _devices;
  Stream<ButtplugClientEvent> get eventStream => _communicator!.eventStream;
}

class ButtplugClientDeviceException implements Exception {
  final String message;
  ButtplugClientDeviceException(this.message) : super();
}
