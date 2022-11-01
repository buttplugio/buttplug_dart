import 'package:json_annotation/json_annotation.dart';
import 'package:buttplug/messages/enums.dart';

part 'messages.g.dart';

class ButtplugMessageException implements Exception {
  final String message;
  ButtplugMessageException(this.message);
}

// Device Utility Classes
@JsonSerializable(fieldRename: FieldRename.pascal)
class ClientGenericDeviceMessageAttributes {
  String featureDescriptor = "";
  ActuatorType actuatorType = ActuatorType.Vibrate;
  int stepCount = 0;

  Map<String, dynamic> toJson() => _$ClientGenericDeviceMessageAttributesToJson(this);
  factory ClientGenericDeviceMessageAttributes.fromJson(Map<String, dynamic> json) =>
      _$ClientGenericDeviceMessageAttributesFromJson(json);
  ClientGenericDeviceMessageAttributes();
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class SensorDeviceMessageAttributes {
  String featureDescriptor = "";
  SensorType sensorType = SensorType.Pressure;
  List<int> stepCount = [0];

  Map<String, dynamic> toJson() => _$SensorDeviceMessageAttributesToJson(this);
  factory SensorDeviceMessageAttributes.fromJson(Map<String, dynamic> json) =>
      _$SensorDeviceMessageAttributesFromJson(json);
  SensorDeviceMessageAttributes();
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class NullDeviceMessageAttributes {
  Map<String, dynamic> toJson() => _$NullDeviceMessageAttributesToJson(this);
  factory NullDeviceMessageAttributes.fromJson(Map<String, dynamic> json) =>
      _$NullDeviceMessageAttributesFromJson(json);
  NullDeviceMessageAttributes();
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class RawDeviceMessageAttributes {
  List<Endpoint> endpoints = [];

  Map<String, dynamic> toJson() => _$RawDeviceMessageAttributesToJson(this);
  factory RawDeviceMessageAttributes.fromJson(Map<String, dynamic> json) => _$RawDeviceMessageAttributesFromJson(json);
  RawDeviceMessageAttributes();
}

@JsonSerializable(fieldRename: FieldRename.pascal, includeIfNull: false)
class ClientDeviceMessageAttributes {
  List<ClientGenericDeviceMessageAttributes>? scalarCmd;
  List<ClientGenericDeviceMessageAttributes>? rotateCmd;
  List<ClientGenericDeviceMessageAttributes>? linearCmd;
  List<SensorDeviceMessageAttributes>? sensorReadCmd;
  List<SensorDeviceMessageAttributes>? sensorSubscribeCmd;
  // This is the only message that should always exist, so don't mark it nullable. If it's null, our parser should throw.
  NullDeviceMessageAttributes stopDeviceCmd = NullDeviceMessageAttributes();
  List<RawDeviceMessageAttributes>? rawReadCmd;
  List<RawDeviceMessageAttributes>? rawWriteCmd;
  List<RawDeviceMessageAttributes>? rawSubscribeCmd;

  Map<String, dynamic> toJson() => _$ClientDeviceMessageAttributesToJson(this);
  factory ClientDeviceMessageAttributes.fromJson(Map<String, dynamic> json) =>
      _$ClientDeviceMessageAttributesFromJson(json);
  ClientDeviceMessageAttributes();
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
  int messageVersion = 3;
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
class ScalarCmd with ButtplugMessage, ButtplugDeviceMessage implements ButtplugClientMessage {
  Map<String, dynamic> toJson() => _$ScalarCmdToJson(this);
  factory ScalarCmd.fromJson(Map<String, dynamic> json) => _$ScalarCmdFromJson(json);
  ScalarCmd();
  @override
  ButtplugClientMessageUnion asClientMessageUnion() {
    var msg = ButtplugClientMessageUnion();
    msg.scalarCmd = this;
    return msg;
  }
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class RotateCmd with ButtplugMessage, ButtplugDeviceMessage implements ButtplugClientMessage {
  Map<String, dynamic> toJson() => _$RotateCmdToJson(this);
  factory RotateCmd.fromJson(Map<String, dynamic> json) => _$RotateCmdFromJson(json);
  RotateCmd();
  @override
  ButtplugClientMessageUnion asClientMessageUnion() {
    var msg = ButtplugClientMessageUnion();
    msg.rotateCmd = this;
    return msg;
  }
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class LinearCmd with ButtplugMessage, ButtplugDeviceMessage implements ButtplugClientMessage {
  Map<String, dynamic> toJson() => _$LinearCmdToJson(this);
  factory LinearCmd.fromJson(Map<String, dynamic> json) => _$LinearCmdFromJson(json);
  LinearCmd();
  @override
  ButtplugClientMessageUnion asClientMessageUnion() {
    var msg = ButtplugClientMessageUnion();
    msg.linearCmd = this;
    return msg;
  }
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class SensorReadCmd with ButtplugMessage, ButtplugDeviceMessage implements ButtplugClientMessage {
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
  ClientDeviceMessageAttributes deviceMessages = ClientDeviceMessageAttributes();
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
  Map<String, dynamic> toJson() => _$DeviceAddedToJson(this);
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
  ServerInfo? serverInfo;
  DeviceList? deviceList;
  DeviceAdded? deviceAdded;
  DeviceRemoved? deviceRemoved;
  SensorReading? sensorReading;
  RawReading? rawReading;

  factory ButtplugServerMessage.fromJson(Map<String, dynamic> json) => _$ButtplugServerMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ButtplugServerMessageToJson(this);

  ButtplugServerMessage();

  int get id {
    if (ok != null) return ok!.id;
    if (serverInfo != null) return serverInfo!.id;
    if (deviceList != null) return deviceList!.id;
    if (deviceAdded != null) return deviceAdded!.id;
    if (deviceRemoved != null) return deviceRemoved!.id;
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
  ScalarCmd? scalarCmd;
  RotateCmd? rotateCmd;
  LinearCmd? linearCmd;
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
    if (scalarCmd != null) return scalarCmd!.id;
    if (rotateCmd != null) return rotateCmd!.id;
    if (linearCmd != null) return linearCmd!.id;
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
