// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientDeviceFeatureOutputInfo _$ClientDeviceFeatureOutputInfoFromJson(
  Map<String, dynamic> json,
) => ClientDeviceFeatureOutputInfo()
  ..value = (json['Value'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList()
  ..duration = (json['Duration'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList();

Map<String, dynamic> _$ClientDeviceFeatureOutputInfoToJson(
  ClientDeviceFeatureOutputInfo instance,
) => <String, dynamic>{'Value': instance.value, 'Duration': instance.duration};

ClientDeviceFeatureOutput _$ClientDeviceFeatureOutputFromJson(
  Map<String, dynamic> json,
) => ClientDeviceFeatureOutput()
  ..value = (json['Value'] as num?)?.toInt()
  ..duration = (json['Duration'] as num?)?.toInt();

Map<String, dynamic> _$ClientDeviceFeatureOutputToJson(
  ClientDeviceFeatureOutput instance,
) => <String, dynamic>{
  'Value': ?instance.value,
  'Duration': ?instance.duration,
};

ClientDeviceFeatureInputInfo _$ClientDeviceFeatureInputInfoFromJson(
  Map<String, dynamic> json,
) => ClientDeviceFeatureInputInfo()
  ..value = (json['Value'] as List<dynamic>)
      .map((e) => (e as List<dynamic>).map((e) => (e as num).toInt()).toList())
      .toList()
  ..command = (json['Command'] as List<dynamic>)
      .map((e) => e as String)
      .toList();

Map<String, dynamic> _$ClientDeviceFeatureInputInfoToJson(
  ClientDeviceFeatureInputInfo instance,
) => <String, dynamic>{'Value': instance.value, 'Command': instance.command};

ClientDeviceFeature _$ClientDeviceFeatureFromJson(Map<String, dynamic> json) =>
    ClientDeviceFeature()
      ..featureIndex = (json['FeatureIndex'] as num).toInt()
      ..featureDescription = json['FeatureDescription'] as String
      ..input = (json['Input'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
          $enumDecode(_$InputTypeEnumMap, k),
          ClientDeviceFeatureInputInfo.fromJson(e as Map<String, dynamic>),
        ),
      )
      ..output = (json['Output'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
          $enumDecode(_$OutputTypeEnumMap, k),
          ClientDeviceFeatureOutputInfo.fromJson(e as Map<String, dynamic>),
        ),
      );

Map<String, dynamic> _$ClientDeviceFeatureToJson(
  ClientDeviceFeature instance,
) => <String, dynamic>{
  'FeatureIndex': instance.featureIndex,
  'FeatureDescription': instance.featureDescription,
  'Input': instance.input?.map((k, e) => MapEntry(_$InputTypeEnumMap[k]!, e)),
  'Output': instance.output?.map(
    (k, e) => MapEntry(_$OutputTypeEnumMap[k]!, e),
  ),
};

const _$InputTypeEnumMap = {
  InputType.battery: 'Battery',
  InputType.pressure: 'Pressure',
  InputType.rssi: 'Rssi',
  InputType.button: 'Button',
  InputType.unknown: 'Unknown',
};

const _$OutputTypeEnumMap = {
  OutputType.vibrate: 'Vibrate',
  OutputType.rotate: 'Rotate',
  OutputType.oscillate: 'Oscillate',
  OutputType.spray: 'Spray',
  OutputType.constrict: 'Constrict',
  OutputType.inflate: 'Inflate',
  OutputType.temperature: 'Temperature',
  OutputType.led: 'Led',
  OutputType.position: 'Position',
  OutputType.hwPositionWithDuration: 'HwPositionWithDuration',
  OutputType.unknown: 'Unknown',
};

RequestServerInfo _$RequestServerInfoFromJson(Map<String, dynamic> json) =>
    RequestServerInfo()
      ..id = (json['Id'] as num).toInt()
      ..clientName = json['ClientName'] as String
      ..protocolVersionMajor = (json['ProtocolVersionMajor'] as num).toInt()
      ..protocolVersionMinor = (json['ProtocolVersionMinor'] as num).toInt();

Map<String, dynamic> _$RequestServerInfoToJson(RequestServerInfo instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'ClientName': instance.clientName,
      'ProtocolVersionMajor': instance.protocolVersionMajor,
      'ProtocolVersionMinor': instance.protocolVersionMinor,
    };

Ping _$PingFromJson(Map<String, dynamic> json) =>
    Ping()..id = (json['Id'] as num).toInt();

Map<String, dynamic> _$PingToJson(Ping instance) => <String, dynamic>{
  'Id': instance.id,
};

RequestDeviceList _$RequestDeviceListFromJson(Map<String, dynamic> json) =>
    RequestDeviceList()..id = (json['Id'] as num).toInt();

Map<String, dynamic> _$RequestDeviceListToJson(RequestDeviceList instance) =>
    <String, dynamic>{'Id': instance.id};

StartScanning _$StartScanningFromJson(Map<String, dynamic> json) =>
    StartScanning()..id = (json['Id'] as num).toInt();

Map<String, dynamic> _$StartScanningToJson(StartScanning instance) =>
    <String, dynamic>{'Id': instance.id};

StopScanning _$StopScanningFromJson(Map<String, dynamic> json) =>
    StopScanning()..id = (json['Id'] as num).toInt();

Map<String, dynamic> _$StopScanningToJson(StopScanning instance) =>
    <String, dynamic>{'Id': instance.id};

StopCmd _$StopCmdFromJson(Map<String, dynamic> json) => StopCmd()
  ..id = (json['Id'] as num).toInt()
  ..deviceIndex = (json['DeviceIndex'] as num?)?.toInt()
  ..featureIndex = (json['FeatureIndex'] as num?)?.toInt()
  ..inputs = json['Inputs'] as bool?
  ..outputs = json['Outputs'] as bool?
  ..command = (json['Command'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(
      $enumDecode(_$OutputTypeEnumMap, k),
      ClientDeviceFeatureOutput.fromJson(e as Map<String, dynamic>),
    ),
  );

Map<String, dynamic> _$StopCmdToJson(StopCmd instance) => <String, dynamic>{
  'Id': instance.id,
  'DeviceIndex': ?instance.deviceIndex,
  'FeatureIndex': ?instance.featureIndex,
  'Inputs': ?instance.inputs,
  'Outputs': ?instance.outputs,
  'Command': instance.command.map(
    (k, e) => MapEntry(_$OutputTypeEnumMap[k]!, e),
  ),
};

OutputCmd _$OutputCmdFromJson(Map<String, dynamic> json) => OutputCmd()
  ..id = (json['Id'] as num).toInt()
  ..deviceIndex = (json['DeviceIndex'] as num).toInt()
  ..featureIndex = (json['FeatureIndex'] as num).toInt()
  ..command = (json['Command'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(
      $enumDecode(_$OutputTypeEnumMap, k),
      ClientDeviceFeatureOutput.fromJson(e as Map<String, dynamic>),
    ),
  );

Map<String, dynamic> _$OutputCmdToJson(OutputCmd instance) => <String, dynamic>{
  'Id': instance.id,
  'DeviceIndex': instance.deviceIndex,
  'FeatureIndex': instance.featureIndex,
  'Command': instance.command.map(
    (k, e) => MapEntry(_$OutputTypeEnumMap[k]!, e),
  ),
};

InputCmd _$InputCmdFromJson(Map<String, dynamic> json) => InputCmd()
  ..id = (json['Id'] as num).toInt()
  ..deviceIndex = (json['DeviceIndex'] as num).toInt()
  ..featureIndex = (json['FeatureIndex'] as num).toInt()
  ..type = $enumDecode(_$InputTypeEnumMap, json['Type'])
  ..command = $enumDecode(_$InputCommandEnumMap, json['Command']);

Map<String, dynamic> _$InputCmdToJson(InputCmd instance) => <String, dynamic>{
  'Id': instance.id,
  'DeviceIndex': instance.deviceIndex,
  'FeatureIndex': instance.featureIndex,
  'Type': _$InputTypeEnumMap[instance.type]!,
  'Command': _$InputCommandEnumMap[instance.command]!,
};

const _$InputCommandEnumMap = {
  InputCommand.read: 'Read',
  InputCommand.subscribe: 'Subscribe',
  InputCommand.unsubscribe: 'Unsubscribe',
  InputCommand.unknown: 'Unknown',
};

Ok _$OkFromJson(Map<String, dynamic> json) =>
    Ok()..id = (json['Id'] as num).toInt();

Map<String, dynamic> _$OkToJson(Ok instance) => <String, dynamic>{
  'Id': instance.id,
};

Error _$ErrorFromJson(Map<String, dynamic> json) => Error()
  ..id = (json['Id'] as num).toInt()
  ..errorCode = (json['ErrorCode'] as num).toInt()
  ..errorMessage = json['ErrorMessage'] as String;

Map<String, dynamic> _$ErrorToJson(Error instance) => <String, dynamic>{
  'Id': instance.id,
  'ErrorCode': instance.errorCode,
  'ErrorMessage': instance.errorMessage,
};

ScanningFinished _$ScanningFinishedFromJson(Map<String, dynamic> json) =>
    ScanningFinished()..id = (json['Id'] as num).toInt();

Map<String, dynamic> _$ScanningFinishedToJson(ScanningFinished instance) =>
    <String, dynamic>{'Id': instance.id};

ServerInfo _$ServerInfoFromJson(Map<String, dynamic> json) => ServerInfo()
  ..id = (json['Id'] as num).toInt()
  ..serverName = json['ServerName'] as String
  ..protocolVersionMajor = (json['ProtocolVersionMajor'] as num).toInt()
  ..protocolVersionMinor = (json['ProtocolVersionMinor'] as num).toInt()
  ..maxPingTime = (json['MaxPingTime'] as num).toInt();

Map<String, dynamic> _$ServerInfoToJson(ServerInfo instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'ServerName': instance.serverName,
      'ProtocolVersionMajor': instance.protocolVersionMajor,
      'ProtocolVersionMinor': instance.protocolVersionMinor,
      'MaxPingTime': instance.maxPingTime,
    };

DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) => DeviceInfo()
  ..deviceIndex = (json['DeviceIndex'] as num).toInt()
  ..deviceName = json['DeviceName'] as String
  ..deviceDisplayName = json['DeviceDisplayName'] as String?
  ..deviceMessageTimingGap = (json['DeviceMessageTimingGap'] as num?)?.toInt()
  ..deviceFeatures = (json['DeviceFeatures'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(
      int.parse(k),
      ClientDeviceFeature.fromJson(e as Map<String, dynamic>),
    ),
  );

Map<String, dynamic> _$DeviceInfoToJson(DeviceInfo instance) =>
    <String, dynamic>{
      'DeviceIndex': instance.deviceIndex,
      'DeviceName': instance.deviceName,
      'DeviceDisplayName': instance.deviceDisplayName,
      'DeviceMessageTimingGap': instance.deviceMessageTimingGap,
      'DeviceFeatures': instance.deviceFeatures.map(
        (k, e) => MapEntry(k.toString(), e),
      ),
    };

DeviceList _$DeviceListFromJson(Map<String, dynamic> json) => DeviceList()
  ..id = (json['Id'] as num).toInt()
  ..devices = (json['Devices'] as Map<String, dynamic>).map(
    (k, e) =>
        MapEntry(int.parse(k), DeviceInfo.fromJson(e as Map<String, dynamic>)),
  );

Map<String, dynamic> _$DeviceListToJson(DeviceList instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Devices': instance.devices.map((k, e) => MapEntry(k.toString(), e)),
    };

InputDataType _$InputDataTypeFromJson(Map<String, dynamic> json) =>
    InputDataType()..value = (json['Value'] as num).toInt();

Map<String, dynamic> _$InputDataTypeToJson(InputDataType instance) =>
    <String, dynamic>{'Value': instance.value};

InputReading _$InputReadingFromJson(Map<String, dynamic> json) => InputReading()
  ..id = (json['Id'] as num).toInt()
  ..deviceIndex = (json['DeviceIndex'] as num).toInt()
  ..featureIndex = (json['FeatureIndex'] as num).toInt()
  ..reading = (json['Reading'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(
      $enumDecode(_$InputTypeEnumMap, k),
      InputDataType.fromJson(e as Map<String, dynamic>),
    ),
  );

Map<String, dynamic> _$InputReadingToJson(InputReading instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'DeviceIndex': instance.deviceIndex,
      'FeatureIndex': instance.featureIndex,
      'Reading': instance.reading.map(
        (k, e) => MapEntry(_$InputTypeEnumMap[k]!, e),
      ),
    };

ButtplugServerMessage _$ButtplugServerMessageFromJson(
  Map<String, dynamic> json,
) => ButtplugServerMessage()
  ..ok = json['Ok'] == null
      ? null
      : Ok.fromJson(json['Ok'] as Map<String, dynamic>)
  ..error = json['Error'] == null
      ? null
      : Error.fromJson(json['Error'] as Map<String, dynamic>)
  ..serverInfo = json['ServerInfo'] == null
      ? null
      : ServerInfo.fromJson(json['ServerInfo'] as Map<String, dynamic>)
  ..deviceList = json['DeviceList'] == null
      ? null
      : DeviceList.fromJson(json['DeviceList'] as Map<String, dynamic>)
  ..inputReading = json['InputReading'] == null
      ? null
      : InputReading.fromJson(json['InputReading'] as Map<String, dynamic>)
  ..scanningFinished = json['ScanningFinished'] == null
      ? null
      : ScanningFinished.fromJson(
          json['ScanningFinished'] as Map<String, dynamic>,
        );

Map<String, dynamic> _$ButtplugServerMessageToJson(
  ButtplugServerMessage instance,
) => <String, dynamic>{
  'Ok': ?instance.ok,
  'Error': ?instance.error,
  'ServerInfo': ?instance.serverInfo,
  'DeviceList': ?instance.deviceList,
  'InputReading': ?instance.inputReading,
  'ScanningFinished': ?instance.scanningFinished,
};

ButtplugClientMessageUnion _$ButtplugClientMessageUnionFromJson(
  Map<String, dynamic> json,
) => ButtplugClientMessageUnion()
  ..requestServerInfo = json['RequestServerInfo'] == null
      ? null
      : RequestServerInfo.fromJson(
          json['RequestServerInfo'] as Map<String, dynamic>,
        )
  ..requestDeviceList = json['RequestDeviceList'] == null
      ? null
      : RequestDeviceList.fromJson(
          json['RequestDeviceList'] as Map<String, dynamic>,
        )
  ..ping = json['Ping'] == null
      ? null
      : Ping.fromJson(json['Ping'] as Map<String, dynamic>)
  ..startScanning = json['StartScanning'] == null
      ? null
      : StartScanning.fromJson(json['StartScanning'] as Map<String, dynamic>)
  ..stopScanning = json['StopScanning'] == null
      ? null
      : StopScanning.fromJson(json['StopScanning'] as Map<String, dynamic>)
  ..stopCmd = json['StopCmd'] == null
      ? null
      : StopCmd.fromJson(json['StopCmd'] as Map<String, dynamic>)
  ..outputCmd = json['OutputCmd'] == null
      ? null
      : OutputCmd.fromJson(json['OutputCmd'] as Map<String, dynamic>)
  ..inputCmd = json['InputCmd'] == null
      ? null
      : InputCmd.fromJson(json['InputCmd'] as Map<String, dynamic>);

Map<String, dynamic> _$ButtplugClientMessageUnionToJson(
  ButtplugClientMessageUnion instance,
) => <String, dynamic>{
  'RequestServerInfo': ?instance.requestServerInfo,
  'RequestDeviceList': ?instance.requestDeviceList,
  'Ping': ?instance.ping,
  'StartScanning': ?instance.startScanning,
  'StopScanning': ?instance.stopScanning,
  'StopCmd': ?instance.stopCmd,
  'OutputCmd': ?instance.outputCmd,
  'InputCmd': ?instance.inputCmd,
};
