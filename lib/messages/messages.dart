import 'package:json_annotation/json_annotation.dart';
part 'messages.g.dart';

@JsonEnum(fieldRename: FieldRename.pascal)
enum OutputType {
  vibrate,
  rotate,
  oscillate,
  spray,
  constrict,
  inflate,
  temperature,
  led,
  position,
  hwPositionWithDuration,
  unknown,
}

@JsonEnum(fieldRename: FieldRename.pascal)
enum InputType { battery, pressure, rssi, button, unknown }

@JsonEnum(fieldRename: FieldRename.pascal)
enum InputCommand { read, subscribe, unsubscribe, unknown }

class ButtplugMessageException implements Exception {
  final String message;
  ButtplugMessageException(this.message);
}

// Device Utility Classes
@JsonSerializable(fieldRename: FieldRename.pascal)
class ClientDeviceFeatureOutputInfo {
  List<int>? value;
  List<int>? duration;
  Map<String, dynamic> toJson() => _$ClientDeviceFeatureOutputInfoToJson(this);
  factory ClientDeviceFeatureOutputInfo.fromJson(Map<String, dynamic> json) =>
      _$ClientDeviceFeatureOutputInfoFromJson(json);
  ClientDeviceFeatureOutputInfo();
}

@JsonSerializable(fieldRename: FieldRename.pascal, includeIfNull: false)
class ClientDeviceFeatureOutput {
  int? value;
  int? duration;
  Map<String, dynamic> toJson() => _$ClientDeviceFeatureOutputToJson(this);
  factory ClientDeviceFeatureOutput.fromJson(Map<String, dynamic> json) => _$ClientDeviceFeatureOutputFromJson(json);
  ClientDeviceFeatureOutput();
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class ClientDeviceFeatureInputInfo {
  List<List<int>> value = [];
  List<String> command = [];
  Map<String, dynamic> toJson() => _$ClientDeviceFeatureInputInfoToJson(this);
  factory ClientDeviceFeatureInputInfo.fromJson(Map<String, dynamic> json) =>
      _$ClientDeviceFeatureInputInfoFromJson(json);
  ClientDeviceFeatureInputInfo();
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class ClientDeviceFeature {
  int featureIndex = 0;
  String featureDescription = "";
  Map<InputType, ClientDeviceFeatureInputInfo>? input;
  Map<OutputType, ClientDeviceFeatureOutputInfo>? output;
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
  int protocolVersionMajor = 4;
  int protocolVersionMinor = 0;
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

@JsonSerializable(fieldRename: FieldRename.pascal, includeIfNull: false)
class StopCmd with ButtplugMessage implements ButtplugClientMessage {
  int? deviceIndex;
  int? featureIndex;
  bool? inputs;
  bool? outputs;
  Map<OutputType, ClientDeviceFeatureOutput> command = {};
  Map<String, dynamic> toJson() => _$StopCmdToJson(this);
  factory StopCmd.fromJson(Map<String, dynamic> json) => _$StopCmdFromJson(json);
  StopCmd();
  @override
  ButtplugClientMessageUnion asClientMessageUnion() {
    var msg = ButtplugClientMessageUnion();
    msg.stopCmd = this;
    return msg;
  }
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class OutputCmd with ButtplugMessage, ButtplugDeviceMessage implements ButtplugClientMessage {
  int featureIndex = 0;
  Map<OutputType, ClientDeviceFeatureOutput> command = {};
  Map<String, dynamic> toJson() => _$OutputCmdToJson(this);
  factory OutputCmd.fromJson(Map<String, dynamic> json) => _$OutputCmdFromJson(json);
  OutputCmd();
  @override
  ButtplugClientMessageUnion asClientMessageUnion() {
    var msg = ButtplugClientMessageUnion();
    msg.outputCmd = this;
    return msg;
  }
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class InputCmd with ButtplugMessage, ButtplugDeviceMessage implements ButtplugClientMessage {
  int featureIndex = 0;
  InputType type = InputType.unknown;
  InputCommand command = InputCommand.unknown;
  Map<String, dynamic> toJson() => _$InputCmdToJson(this);
  factory InputCmd.fromJson(Map<String, dynamic> json) => _$InputCmdFromJson(json);
  InputCmd();
  @override
  ButtplugClientMessageUnion asClientMessageUnion() {
    var msg = ButtplugClientMessageUnion();
    msg.inputCmd = this;
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
  int protocolVersionMajor = 0;
  int protocolVersionMinor = 0;
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
  int? deviceMessageTimingGap;
  Map<int, ClientDeviceFeature> deviceFeatures = {};
  Map<String, dynamic> toJson() => _$DeviceInfoToJson(this);
  factory DeviceInfo.fromJson(Map<String, dynamic> json) => _$DeviceInfoFromJson(json);
  DeviceInfo();
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class DeviceList with ButtplugMessage {
  Map<int, DeviceInfo> devices = {};
  Map<String, dynamic> toJson() => _$DeviceListToJson(this);
  factory DeviceList.fromJson(Map<String, dynamic> json) => _$DeviceListFromJson(json);
  DeviceList();
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class InputDataType {
  int value = 0;
  Map<String, dynamic> toJson() => _$InputDataTypeToJson(this);
  factory InputDataType.fromJson(Map<String, dynamic> json) => _$InputDataTypeFromJson(json);
  InputDataType();
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class InputReading with ButtplugMessage, ButtplugDeviceMessage {
  int featureIndex = 0;
  Map<InputType, InputDataType> reading = {};
  Map<String, dynamic> toJson() => _$InputReadingToJson(this);
  factory InputReading.fromJson(Map<String, dynamic> json) => _$InputReadingFromJson(json);
  InputReading();
}
// Incoming/Outgoing Unions

@JsonSerializable(fieldRename: FieldRename.pascal, includeIfNull: false)
class ButtplugServerMessage {
  Ok? ok;
  Error? error;
  ServerInfo? serverInfo;
  DeviceList? deviceList;
  InputReading? inputReading;
  ScanningFinished? scanningFinished;

  factory ButtplugServerMessage.fromJson(Map<String, dynamic> json) => _$ButtplugServerMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ButtplugServerMessageToJson(this);

  ButtplugServerMessage();

  int get id {
    if (ok != null) return ok!.id;
    if (error != null) return error!.id;
    if (serverInfo != null) return serverInfo!.id;
    if (deviceList != null) return deviceList!.id;
    if (inputReading != null) return inputReading!.id;
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
  StopCmd? stopCmd;
  OutputCmd? outputCmd;
  InputCmd? inputCmd;

  factory ButtplugClientMessageUnion.fromJson(Map<String, dynamic> json) => _$ButtplugClientMessageUnionFromJson(json);

  Map<String, dynamic> toJson() => _$ButtplugClientMessageUnionToJson(this);

  ButtplugClientMessageUnion();

  int get id {
    if (requestDeviceList != null) return requestDeviceList!.id;
    if (requestServerInfo != null) return requestServerInfo!.id;
    if (ping != null) return ping!.id;
    if (startScanning != null) return startScanning!.id;
    if (stopScanning != null) return stopScanning!.id;
    if (stopCmd != null) return stopCmd!.id;
    if (outputCmd != null) return outputCmd!.id;
    if (inputCmd != null) return inputCmd!.id;
    throw ButtplugMessageException("No client message id available");
  }
}
