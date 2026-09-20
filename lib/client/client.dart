import 'dart:async';
import 'dart:convert';

import 'package:buttplug/buttplug.dart';

class ButtplugClientException implements Exception {
  final String message;
  ButtplugClientException(this.message);

  @override
  String toString() => message;
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

class DeviceListReceivedEvent extends ButtplugClientEvent {
  DeviceListReceivedEvent();
}

class DisconnectEvent extends ButtplugClientEvent {
  DisconnectEvent();
}

class ButtplugClient {
  final String name;
  String? _serverName;
  ButtplugClientCommunicator? _communicator;
  StreamSubscription<ButtplugServerMessage>? _messageSubscription;
  final Map<int, ButtplugClientDevice> _devices = {};
  bool _isConnected = false;
  bool _connecting = false;
  bool _disconnecting = false;
  bool _connectionCancelled = false;

  ButtplugClient(this.name);

  Future<void> connect(ButtplugClientConnector connector) async {
    if (_connecting || _disconnecting || _isConnected || _communicator?.connected() == true) {
      throw ButtplugClientException("Client is already connected");
    }
    _connecting = true;
    _connectionCancelled = false;
    final communicator = ButtplugClientCommunicator(connector);
    _communicator = communicator;
    try {
      await _messageSubscription?.cancel();
      if (_connectionCancelled) throw ButtplugClientException('Connection cancelled');
      _messageSubscription = connector.messageStream.listen(
        (message) => _handleMessage(communicator, message),
        onDone: () => _handleDisconnect(communicator),
        onError: (_, _) => _handleDisconnect(communicator),
      );
      await communicator.connect();
      if (_connectionCancelled || !identical(_communicator, communicator)) {
        throw ButtplugClientException('Connection cancelled');
      }
      final requestServerInfo = RequestServerInfo()..clientName = name;
      final serverInfo = await communicator.sendMessageExpectReply(requestServerInfo);
      if (serverInfo.serverInfo == null) {
        throw ButtplugClientException(
          "Did not receive ServerInfo message back from server on handshake: ${jsonEncode(serverInfo.toJson())}.",
        );
      }
      _serverName = serverInfo.serverInfo!.serverName;

      final deviceListWrapper = await communicator.sendMessageExpectReply(RequestDeviceList());
      if (deviceListWrapper.deviceList == null) {
        throw ButtplugClientException("Did not receive DeviceList message back from server on handshake.");
      }
      if (_connectionCancelled || !identical(_communicator, communicator) || !communicator.connected()) {
        throw ButtplugClientException('Connection closed during handshake');
      }
      _replaceDevices(deviceListWrapper.deviceList!, communicator);
      _isConnected = true;
      communicator.eventStreamController.add(DeviceListReceivedEvent());
    } catch (_) {
      try {
        await _cleanupConnection(communicator);
      } catch (_) {
        // Preserve the connection failure if transport cleanup also fails.
      }
      rethrow;
    } finally {
      _connecting = false;
    }
  }

  bool connected() => _isConnected && (_communicator?.connected() ?? false);

  void _handleMessage(ButtplugClientCommunicator communicator, ButtplugServerMessage message) {
    if (!identical(_communicator, communicator) || !_isConnected || message.deviceList == null) return;
    _replaceDevices(message.deviceList!, communicator);
    communicator.eventStreamController.add(DeviceListReceivedEvent());
  }

  void _replaceDevices(DeviceList list, ButtplugClientCommunicator communicator) {
    final incoming = list.devices;
    for (final info in incoming.values) {
      if (!_devices.containsKey(info.deviceIndex)) {
        final device = ButtplugClientDevice(info, communicator);
        _devices[device.index] = device;
        communicator.eventStreamController.add(DeviceAddedEvent(device));
      }
    }
    final removed = _devices.keys.where((index) => !incoming.containsKey(index)).toList();
    for (final index in removed) {
      final device = _devices.remove(index)!;
      device.markDisconnected();
      communicator.eventStreamController.add(DeviceRemovedEvent(device));
    }
  }

  void _handleDisconnect(ButtplugClientCommunicator communicator) {
    if (!identical(_communicator, communicator)) return;
    if (!_isConnected && _devices.isEmpty) return;
    _isConnected = false;
    for (final device in _devices.values) {
      device.markDisconnected();
    }
    _devices.clear();
    _communicator?.eventStreamController.add(DisconnectEvent());
  }

  Future<void> _cleanupConnection(ButtplugClientCommunicator communicator) async {
    final ownsConnection = identical(_communicator, communicator);
    final subscription = ownsConnection ? _messageSubscription : null;
    if (ownsConnection) {
      _connectionCancelled = true;
      _disconnecting = true;
      _handleDisconnect(communicator);
      _messageSubscription = null;
    }
    try {
      await communicator.disconnect();
    } finally {
      try {
        await subscription?.cancel();
      } finally {
        if (ownsConnection) _disconnecting = false;
      }
    }
  }

  Future<void> disconnect() async {
    final communicator = _communicator;
    if (communicator == null) return;
    await _cleanupConnection(communicator);
  }

  Future<void> startScanning() async => _communicator!.sendMessageExpectOk(StartScanning());
  Future<void> stopScanning() async => _communicator!.sendMessageExpectOk(StopScanning());
  Future<void> stopAllDevices() async => _communicator!.sendMessageExpectOk(StopCmd());

  String? get serverName => _serverName;
  Map<int, ButtplugClientDevice> get devices => _devices;
  Stream<ButtplugClientEvent> get eventStream => _communicator!.eventStream;
}

class ButtplugClientDeviceException implements Exception {
  final String message;
  ButtplugClientDeviceException(this.message) : super();
}
