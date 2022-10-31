import 'package:json_annotation/json_annotation.dart';
import 'package:buttplug/messages/enums.dart';

part 'messages.g.dart';

class ButtplugMessageException implements Exception {
  String message;
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

// Client Messages

@JsonSerializable(fieldRename: FieldRename.pascal)
class RequestServerInfo with ButtplugMessage {
  String clientName = "";
  // This will not change until we rev this message set, so set it statically.
  int messageVersion = 3;
  Map<String, dynamic> toJson() => _$RequestServerInfoToJson(this);
  factory RequestServerInfo.fromJson(Map<String, dynamic> json) => _$RequestServerInfoFromJson(json);
  RequestServerInfo();
  ButtplugClientMessage asClientMessage() {
    var msg = ButtplugClientMessage();
    msg.requestServerInfo = this;
    return msg;
  }
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class Ping with ButtplugMessage {
  Map<String, dynamic> toJson() => _$PingToJson(this);
  factory Ping.fromJson(Map<String, dynamic> json) => _$PingFromJson(json);
  Ping();
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class RequestDeviceList with ButtplugMessage {
  Map<String, dynamic> toJson() => _$RequestDeviceListToJson(this);
  factory RequestDeviceList.fromJson(Map<String, dynamic> json) => _$RequestDeviceListFromJson(json);
  RequestDeviceList();
}

// Server Messages

@JsonSerializable(fieldRename: FieldRename.pascal)
class Ok with ButtplugMessage {
  Map<String, dynamic> toJson() => _$OkToJson(this);
  factory Ok.fromJson(Map<String, dynamic> json) => _$OkFromJson(json);
  Ok();
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
class DeviceList with ButtplugMessage {
  List<DeviceAdded> devices = [];
  Map<String, dynamic> toJson() => _$DeviceListToJson(this);
  factory DeviceList.fromJson(Map<String, dynamic> json) => _$DeviceListFromJson(json);
  DeviceList();
}

@JsonSerializable(fieldRename: FieldRename.pascal, includeIfNull: false)
class DeviceAdded with ButtplugMessage {
  int deviceIndex = 0;
  String deviceName = "";
  String? deviceDisplayName;
  int? messageTimingGap;
  ClientDeviceMessageAttributes deviceMessages = ClientDeviceMessageAttributes();
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

// Incoming/Outgoing Unions

@JsonSerializable(fieldRename: FieldRename.pascal, includeIfNull: false)
class ButtplugServerMessage {
  Ok? ok;
  ServerInfo? serverInfo;
  DeviceList? deviceList;
  DeviceAdded? deviceAdded;
  DeviceRemoved? deviceRemoved;

  factory ButtplugServerMessage.fromJson(Map<String, dynamic> json) => _$ButtplugServerMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ButtplugServerMessageToJson(this);

  ButtplugServerMessage();

  int get id {
    if (ok != null) return ok!.id;
    if (serverInfo != null) return serverInfo!.id;
    if (deviceList != null) return deviceList!.id;
    if (deviceAdded != null) return deviceAdded!.id;
    if (deviceRemoved != null) return deviceRemoved!.id;
    throw ButtplugMessageException("No id available");
  }
}

@JsonSerializable(fieldRename: FieldRename.pascal, includeIfNull: false)
class ButtplugClientMessage {
  RequestServerInfo? requestServerInfo;
  RequestDeviceList? requestDeviceList;
  Ping? ping;

  factory ButtplugClientMessage.fromJson(Map<String, dynamic> json) => _$ButtplugClientMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ButtplugClientMessageToJson(this);

  ButtplugClientMessage();
}