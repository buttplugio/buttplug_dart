import 'package:json_annotation/json_annotation.dart';

part 'messages.g.dart';

class ButtplugMessageException implements Exception {
  final String message;
  ButtplugMessageException(this.message);
}

// Device Utility Classes
@JsonSerializable(fieldRename: FieldRename.pascal)
class ClientDeviceFeatureActuator {
  int stepCount = 0;
  List<String> messages = [];
  Map<String, dynamic> toJson() => _$ClientDeviceFeatureActuatorToJson(this);
  factory ClientDeviceFeatureActuator.fromJson(Map<String, dynamic> json) =>
      _$ClientDeviceFeatureActuatorFromJson(json);
  ClientDeviceFeatureActuator();
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class ClientDeviceFeatureSensor {
  List<List<int>> valueRange = [];
  List<String> messages = [];
  Map<String, dynamic> toJson() => _$ClientDeviceFeatureSensorToJson(this);
  factory ClientDeviceFeatureSensor.fromJson(Map<String, dynamic> json) => _$ClientDeviceFeatureSensorFromJson(json);
  ClientDeviceFeatureSensor();
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class ClientDeviceFeatureRaw {
  List<String> endpoints = [];
  List<String> messages = [];
  Map<String, dynamic> toJson() => _$ClientDeviceFeatureRawToJson(this);
  factory ClientDeviceFeatureRaw.fromJson(Map<String, dynamic> json) => _$ClientDeviceFeatureRawFromJson(json);
  ClientDeviceFeatureRaw();
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class ClientDeviceFeature {
  int featureIndex = 0;
  String description = "";
  String featureType = "";
  ClientDeviceFeatureActuator? actuator;
  ClientDeviceFeatureSensor? sensor;
  ClientDeviceFeatureRaw? raw;
  Map<String, dynamic> toJson() => _$ClientDeviceFeatureToJson(this);
  factory ClientDeviceFeature.fromJson(Map<String, dynamic> json) => _$ClientDeviceFeatureFromJson(json);
  ClientDeviceFeature();
}

mixin ButtplugMessage {
  int id = 0;
}

mixin ButtplugDeviceMessage {
  int deviceIndex = 0;
}

abstract class ButtplugClientMessage with ButtplugMessage {
  ButtplugClientMessageUnion asClientMessageUnion();
}

// Client Messages

@JsonSerializable(fieldRename: FieldRename.pascal)
class RequestServerInfo with ButtplugMessage implements ButtplugClientMessage {
  String clientName = "";
  // This will not change until we rev this message set, so set it statically.
  int messageVersion = 4;
  Map<String, dynamic> toJson() => _$RequestServerInfoToJson(this);
  factory RequestServerInfo.fromJson(Map<String, dynamic> json) => _$RequestServerInfoFromJson(json);
  RequestServerInfo();
  @override
  ButtplugClientMessageUnion asClientMessageUnion() {
    var msg = ButtplugClientMessageUnion();
    msg.requestServerInfo = this;
    return msg;
  }
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class Ping with ButtplugMessage implements ButtplugClientMessage {
  Map<String, dynamic> toJson() => _$PingToJson(this);
  factory Ping.fromJson(Map<String, dynamic> json) => _$PingFromJson(json);
  Ping();
  @override
  ButtplugClientMessageUnion asClientMessageUnion() {
    var msg = ButtplugClientMessageUnion();
    msg.ping = this;
    return msg;
  }
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class RequestDeviceList with ButtplugMessage implements ButtplugClientMessage {
  Map<String, dynamic> toJson() => _$RequestDeviceListToJson(this);
  factory RequestDeviceList.fromJson(Map<String, dynamic> json) => _$RequestDeviceListFromJson(json);
  RequestDeviceList();
  @override
  ButtplugClientMessageUnion asClientMessageUnion() {
    var msg = ButtplugClientMessageUnion();
    msg.requestDeviceList = this;
    return msg;
  }
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class StartScanning with ButtplugMessage implements ButtplugClientMessage {
  Map<String, dynamic> toJson() => _$StartScanningToJson(this);
  factory StartScanning.fromJson(Map<String, dynamic> json) => _$StartScanningFromJson(json);
  StartScanning();
  @override
  ButtplugClientMessageUnion asClientMessageUnion() {
    var msg = ButtplugClientMessageUnion();
    msg.startScanning = this;
    return msg;
  }
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class StopScanning with ButtplugMessage implements ButtplugClientMessage {
  Map<String, dynamic> toJson() => _$StopScanningToJson(this);
  factory StopScanning.fromJson(Map<String, dynamic> json) => _$StopScanningFromJson(json);
  StopScanning();
  @override
  ButtplugClientMessageUnion asClientMessageUnion() {
    var msg = ButtplugClientMessageUnion();
    msg.stopScanning = this;
    return msg;
  }
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class StopAllDevices with ButtplugMessage implements ButtplugClientMessage {
  Map<String, dynamic> toJson() => _$StopAllDevicesToJson(this);
  factory StopAllDevices.fromJson(Map<String, dynamic> json) => _$StopAllDevicesFromJson(json);
  StopAllDevices();
  @override
  ButtplugClientMessageUnion asClientMessageUnion() {
    var msg = ButtplugClientMessageUnion();
    msg.stopAllDevices = this;
    return msg;
  }
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class ValueCmd with ButtplugMessage, ButtplugDeviceMessage implements ButtplugClientMessage {
  int featureIndex = 0;
  int value = 0;
  String actuatorType = "";
  Map<String, dynamic> toJson() => _$ValueCmdToJson(this);
  factory ValueCmd.fromJson(Map<String, dynamic> json) => _$ValueCmdFromJson(json);
  ValueCmd();
  @override
  ButtplugClientMessageUnion asClientMessageUnion() {
    var msg = ButtplugClientMessageUnion();
    msg.valueCmd = this;
    return msg;
  }
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class ValueWithParameterCmd with ButtplugMessage, ButtplugDeviceMessage implements ButtplugClientMessage {
  int featureIndex = 0;
  int value = 0;
  int parameter = 0;
  String actuatorType = "";
  Map<String, dynamic> toJson() => _$ValueWithParameterCmdToJson(this);
  factory ValueWithParameterCmd.fromJson(Map<String, dynamic> json) => _$ValueWithParameterCmdFromJson(json);
  ValueWithParameterCmd();
  @override
  ButtplugClientMessageUnion asClientMessageUnion() {
    var msg = ButtplugClientMessageUnion();
    msg.valueWithParameterCmd = this;
    return msg;
  }
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class SensorReadCmd with ButtplugMessage, ButtplugDeviceMessage implements ButtplugClientMessage {
  int sensorIndex = 0;
  String sensorType = "";
  Map<String, dynamic> toJson() => _$SensorReadCmdToJson(this);
  factory SensorReadCmd.fromJson(Map<String, dynamic> json) => _$SensorReadCmdFromJson(json);
  SensorReadCmd();
  @override
  ButtplugClientMessageUnion asClientMessageUnion() {
    var msg = ButtplugClientMessageUnion();
    msg.sensorReadCmd = this;
    return msg;
  }
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class SensorSubscribeCmd with ButtplugMessage, ButtplugDeviceMessage implements ButtplugClientMessage {
  Map<String, dynamic> toJson() => _$SensorSubscribeCmdToJson(this);
  factory SensorSubscribeCmd.fromJson(Map<String, dynamic> json) => _$SensorSubscribeCmdFromJson(json);
  SensorSubscribeCmd();
  @override
  ButtplugClientMessageUnion asClientMessageUnion() {
    var msg = ButtplugClientMessageUnion();
    msg.sensorSubscribeCmd = this;
    return msg;
  }
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class SensorUnsubscribeCmd with ButtplugMessage, ButtplugDeviceMessage implements ButtplugClientMessage {
  Map<String, dynamic> toJson() => _$SensorUnsubscribeCmdToJson(this);
  factory SensorUnsubscribeCmd.fromJson(Map<String, dynamic> json) => _$SensorUnsubscribeCmdFromJson(json);
  SensorUnsubscribeCmd();
  @override
  ButtplugClientMessageUnion asClientMessageUnion() {
    var msg = ButtplugClientMessageUnion();
    msg.sensorUnsubscribeCmd = this;
    return msg;
  }
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class RawReadCmd with ButtplugMessage, ButtplugDeviceMessage implements ButtplugClientMessage {
  Map<String, dynamic> toJson() => _$RawReadCmdToJson(this);
  factory RawReadCmd.fromJson(Map<String, dynamic> json) => _$RawReadCmdFromJson(json);
  RawReadCmd();
  @override
  ButtplugClientMessageUnion asClientMessageUnion() {
    var msg = ButtplugClientMessageUnion();
    msg.rawReadCmd = this;
    return msg;
  }
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class RawWriteCmd with ButtplugMessage, ButtplugDeviceMessage implements ButtplugClientMessage {
  Map<String, dynamic> toJson() => _$RawWriteCmdToJson(this);
  factory RawWriteCmd.fromJson(Map<String, dynamic> json) => _$RawWriteCmdFromJson(json);
  RawWriteCmd();
  @override
  ButtplugClientMessageUnion asClientMessageUnion() {
    var msg = ButtplugClientMessageUnion();
    msg.rawWriteCmd = this;
    return msg;
  }
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class RawSubscribeCmd with ButtplugMessage, ButtplugDeviceMessage implements ButtplugClientMessage {
  Map<String, dynamic> toJson() => _$RawSubscribeCmdToJson(this);
  factory RawSubscribeCmd.fromJson(Map<String, dynamic> json) => _$RawSubscribeCmdFromJson(json);
  RawSubscribeCmd();
  @override
  ButtplugClientMessageUnion asClientMessageUnion() {
    var msg = ButtplugClientMessageUnion();
    msg.rawSubscribeCmd = this;
    return msg;
  }
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class RawUnsubscribeCmd with ButtplugMessage, ButtplugDeviceMessage implements ButtplugClientMessage {
  Map<String, dynamic> toJson() => _$RawUnsubscribeCmdToJson(this);
  factory RawUnsubscribeCmd.fromJson(Map<String, dynamic> json) => _$RawUnsubscribeCmdFromJson(json);
  RawUnsubscribeCmd();
  @override
  ButtplugClientMessageUnion asClientMessageUnion() {
    var msg = ButtplugClientMessageUnion();
    msg.rawUnsubscribeCmd = this;
    return msg;
  }
}

// Server Messages

@JsonSerializable(fieldRename: FieldRename.pascal)
class Ok with ButtplugMessage {
  Map<String, dynamic> toJson() => _$OkToJson(this);
  factory Ok.fromJson(Map<String, dynamic> json) => _$OkFromJson(json);
  Ok();
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class Error with ButtplugMessage {
  int errorCode = 0;
  String errorMessage = "";
  Map<String, dynamic> toJson() => _$ErrorToJson(this);
  factory Error.fromJson(Map<String, dynamic> json) => _$ErrorFromJson(json);
  Error();
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class ScanningFinished with ButtplugMessage {
  Map<String, dynamic> toJson() => _$ScanningFinishedToJson(this);
  factory ScanningFinished.fromJson(Map<String, dynamic> json) => _$ScanningFinishedFromJson(json);
  ScanningFinished();
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class ServerInfo with ButtplugMessage {
  String serverName = "";
  // This should also be 3, but we'll check that on connect.
  int messageVersion = 0;
  int maxPingTime = 0;
  Map<String, dynamic> toJson() => _$ServerInfoToJson(this);
  factory ServerInfo.fromJson(Map<String, dynamic> json) => _$ServerInfoFromJson(json);
  ServerInfo();
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class DeviceInfo {
  int deviceIndex = 0;
  String deviceName = "";
  String? deviceDisplayName;
  int? messageTimingGap;
  List<ClientDeviceFeature> deviceFeatures = [];
  Map<String, dynamic> toJson() => _$DeviceInfoToJson(this);
  factory DeviceInfo.fromJson(Map<String, dynamic> json) => _$DeviceInfoFromJson(json);
  DeviceInfo();
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class DeviceList with ButtplugMessage {
  List<DeviceInfo> devices = [];
  Map<String, dynamic> toJson() => _$DeviceListToJson(this);
  factory DeviceList.fromJson(Map<String, dynamic> json) => _$DeviceListFromJson(json);
  DeviceList();
}

@JsonSerializable(fieldRename: FieldRename.pascal, includeIfNull: false)
class DeviceAdded extends DeviceInfo with ButtplugMessage {
  // toJson inherited from DeviceInfo
  factory DeviceAdded.fromJson(Map<String, dynamic> json) => _$DeviceAddedFromJson(json);
  DeviceAdded();
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class DeviceRemoved with ButtplugMessage {
  int deviceIndex = 0;
  Map<String, dynamic> toJson() => _$DeviceRemovedToJson(this);
  factory DeviceRemoved.fromJson(Map<String, dynamic> json) => _$DeviceRemovedFromJson(json);
  DeviceRemoved();
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class SensorReading with ButtplugMessage, ButtplugDeviceMessage {
  int sensorIndex = 0;
  String sensorType = "";
  List<int> data = [];
  Map<String, dynamic> toJson() => _$SensorReadingToJson(this);
  factory SensorReading.fromJson(Map<String, dynamic> json) => _$SensorReadingFromJson(json);
  SensorReading();
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class RawReading with ButtplugMessage, ButtplugDeviceMessage {
  Map<String, dynamic> toJson() => _$RawReadingToJson(this);
  factory RawReading.fromJson(Map<String, dynamic> json) => _$RawReadingFromJson(json);
  RawReading();
}

// Incoming/Outgoing Unions

@JsonSerializable(fieldRename: FieldRename.pascal, includeIfNull: false)
class ButtplugServerMessage {
  Ok? ok;
  Error? error;
  ServerInfo? serverInfo;
  DeviceList? deviceList;
  DeviceAdded? deviceAdded;
  DeviceRemoved? deviceRemoved;
  SensorReading? sensorReading;
  RawReading? rawReading;
  ScanningFinished? scanningFinished;

  factory ButtplugServerMessage.fromJson(Map<String, dynamic> json) => _$ButtplugServerMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ButtplugServerMessageToJson(this);

  ButtplugServerMessage();

  int get id {
    if (ok != null) return ok!.id;
    if (error != null) return error!.id;
    if (serverInfo != null) return serverInfo!.id;
    if (deviceList != null) return deviceList!.id;
    if (deviceAdded != null) return deviceAdded!.id;
    if (deviceRemoved != null) return deviceRemoved!.id;
    if (sensorReading != null) return sensorReading!.id;
    if (rawReading != null) return rawReading!.id;
    if (scanningFinished != null) return scanningFinished!.id;
    throw ButtplugMessageException("No server message id available");
  }
}

@JsonSerializable(fieldRename: FieldRename.pascal, includeIfNull: false)
class ButtplugClientMessageUnion {
  RequestServerInfo? requestServerInfo;
  RequestDeviceList? requestDeviceList;
  Ping? ping;
  StartScanning? startScanning;
  StopScanning? stopScanning;
  StopAllDevices? stopAllDevices;
  ValueCmd? valueCmd;
  ValueWithParameterCmd? valueWithParameterCmd;
  SensorReadCmd? sensorReadCmd;
  SensorSubscribeCmd? sensorSubscribeCmd;
  SensorUnsubscribeCmd? sensorUnsubscribeCmd;
  RawReadCmd? rawReadCmd;
  RawWriteCmd? rawWriteCmd;
  RawSubscribeCmd? rawSubscribeCmd;
  RawUnsubscribeCmd? rawUnsubscribeCmd;

  factory ButtplugClientMessageUnion.fromJson(Map<String, dynamic> json) => _$ButtplugClientMessageUnionFromJson(json);

  Map<String, dynamic> toJson() => _$ButtplugClientMessageUnionToJson(this);

  ButtplugClientMessageUnion();

  int get id {
    if (requestDeviceList != null) return requestDeviceList!.id;
    if (requestServerInfo != null) return requestServerInfo!.id;
    if (ping != null) return ping!.id;
    if (startScanning != null) return startScanning!.id;
    if (stopScanning != null) return stopScanning!.id;
    if (stopAllDevices != null) return stopAllDevices!.id;
    if (valueCmd != null) return valueCmd!.id;
    if (valueWithParameterCmd != null) return valueWithParameterCmd!.id;
    if (sensorReadCmd != null) return sensorReadCmd!.id;
    if (sensorSubscribeCmd != null) return sensorSubscribeCmd!.id;
    if (sensorUnsubscribeCmd != null) return sensorUnsubscribeCmd!.id;
    if (rawReadCmd != null) return rawReadCmd!.id;
    if (rawSubscribeCmd != null) return rawSubscribeCmd!.id;
    if (rawUnsubscribeCmd != null) return rawUnsubscribeCmd!.id;
    if (rawWriteCmd != null) return rawWriteCmd!.id;
    throw ButtplugMessageException("No client message id available");
  }
}
