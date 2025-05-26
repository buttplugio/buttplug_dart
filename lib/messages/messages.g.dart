// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientDeviceFeatureActuator _$ClientDeviceFeatureActuatorFromJson(
        Map<String, dynamic> json) =>
    ClientDeviceFeatureActuator()
      ..stepCount = (json['StepCount'] as num).toInt()
      ..messages =
          (json['Messages'] as List<dynamic>).map((e) => e as String).toList();

Map<String, dynamic> _$ClientDeviceFeatureActuatorToJson(
        ClientDeviceFeatureActuator instance) =>
    <String, dynamic>{
      'StepCount': instance.stepCount,
      'Messages': instance.messages,
    };

ClientDeviceFeatureSensor _$ClientDeviceFeatureSensorFromJson(
        Map<String, dynamic> json) =>
    ClientDeviceFeatureSensor()
      ..valueRange = (json['ValueRange'] as List<dynamic>)
          .map((e) =>
              (e as List<dynamic>).map((e) => (e as num).toInt()).toList())
          .toList()
      ..messages =
          (json['Messages'] as List<dynamic>).map((e) => e as String).toList();

Map<String, dynamic> _$ClientDeviceFeatureSensorToJson(
        ClientDeviceFeatureSensor instance) =>
    <String, dynamic>{
      'ValueRange': instance.valueRange,
      'Messages': instance.messages,
    };

ClientDeviceFeatureRaw _$ClientDeviceFeatureRawFromJson(
        Map<String, dynamic> json) =>
    ClientDeviceFeatureRaw()
      ..endpoints =
          (json['Endpoints'] as List<dynamic>).map((e) => e as String).toList()
      ..messages =
          (json['Messages'] as List<dynamic>).map((e) => e as String).toList();

Map<String, dynamic> _$ClientDeviceFeatureRawToJson(
        ClientDeviceFeatureRaw instance) =>
    <String, dynamic>{
      'Endpoints': instance.endpoints,
      'Messages': instance.messages,
    };

ClientDeviceFeature _$ClientDeviceFeatureFromJson(Map<String, dynamic> json) =>
    ClientDeviceFeature()
      ..featureIndex = (json['FeatureIndex'] as num).toInt()
      ..description = json['Description'] as String
      ..featureType = json['FeatureType'] as String
      ..actuator = json['Actuator'] == null
          ? null
          : ClientDeviceFeatureActuator.fromJson(
              json['Actuator'] as Map<String, dynamic>)
      ..sensor = json['Sensor'] == null
          ? null
          : ClientDeviceFeatureSensor.fromJson(
              json['Sensor'] as Map<String, dynamic>)
      ..raw = json['Raw'] == null
          ? null
          : ClientDeviceFeatureRaw.fromJson(
              json['Raw'] as Map<String, dynamic>);

Map<String, dynamic> _$ClientDeviceFeatureToJson(
        ClientDeviceFeature instance) =>
    <String, dynamic>{
      'FeatureIndex': instance.featureIndex,
      'Description': instance.description,
      'FeatureType': instance.featureType,
      'Actuator': instance.actuator,
      'Sensor': instance.sensor,
      'Raw': instance.raw,
    };

RequestServerInfo _$RequestServerInfoFromJson(Map<String, dynamic> json) =>
    RequestServerInfo()
      ..id = (json['Id'] as num).toInt()
      ..clientName = json['ClientName'] as String
      ..messageVersion = (json['MessageVersion'] as num).toInt();

Map<String, dynamic> _$RequestServerInfoToJson(RequestServerInfo instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'ClientName': instance.clientName,
      'MessageVersion': instance.messageVersion,
    };

Ping _$PingFromJson(Map<String, dynamic> json) =>
    Ping()..id = (json['Id'] as num).toInt();

Map<String, dynamic> _$PingToJson(Ping instance) => <String, dynamic>{
      'Id': instance.id,
    };

RequestDeviceList _$RequestDeviceListFromJson(Map<String, dynamic> json) =>
    RequestDeviceList()..id = (json['Id'] as num).toInt();

Map<String, dynamic> _$RequestDeviceListToJson(RequestDeviceList instance) =>
    <String, dynamic>{
      'Id': instance.id,
    };

StartScanning _$StartScanningFromJson(Map<String, dynamic> json) =>
    StartScanning()..id = (json['Id'] as num).toInt();

Map<String, dynamic> _$StartScanningToJson(StartScanning instance) =>
    <String, dynamic>{
      'Id': instance.id,
    };

StopScanning _$StopScanningFromJson(Map<String, dynamic> json) =>
    StopScanning()..id = (json['Id'] as num).toInt();

Map<String, dynamic> _$StopScanningToJson(StopScanning instance) =>
    <String, dynamic>{
      'Id': instance.id,
    };

StopAllDevices _$StopAllDevicesFromJson(Map<String, dynamic> json) =>
    StopAllDevices()..id = (json['Id'] as num).toInt();

Map<String, dynamic> _$StopAllDevicesToJson(StopAllDevices instance) =>
    <String, dynamic>{
      'Id': instance.id,
    };

ValueCmd _$ValueCmdFromJson(Map<String, dynamic> json) => ValueCmd()
  ..id = (json['Id'] as num).toInt()
  ..deviceIndex = (json['DeviceIndex'] as num).toInt()
  ..featureIndex = (json['FeatureIndex'] as num).toInt()
  ..value = (json['Value'] as num).toInt()
  ..actuatorType = json['ActuatorType'] as String;

Map<String, dynamic> _$ValueCmdToJson(ValueCmd instance) => <String, dynamic>{
      'Id': instance.id,
      'DeviceIndex': instance.deviceIndex,
      'FeatureIndex': instance.featureIndex,
      'Value': instance.value,
      'ActuatorType': instance.actuatorType,
    };

ValueWithParameterCmd _$ValueWithParameterCmdFromJson(
        Map<String, dynamic> json) =>
    ValueWithParameterCmd()
      ..id = (json['Id'] as num).toInt()
      ..deviceIndex = (json['DeviceIndex'] as num).toInt()
      ..featureIndex = (json['FeatureIndex'] as num).toInt()
      ..value = (json['Value'] as num).toInt()
      ..parameter = (json['Parameter'] as num).toInt()
      ..actuatorType = json['ActuatorType'] as String;

Map<String, dynamic> _$ValueWithParameterCmdToJson(
        ValueWithParameterCmd instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'DeviceIndex': instance.deviceIndex,
      'FeatureIndex': instance.featureIndex,
      'Value': instance.value,
      'Parameter': instance.parameter,
      'ActuatorType': instance.actuatorType,
    };

SensorReadCmd _$SensorReadCmdFromJson(Map<String, dynamic> json) =>
    SensorReadCmd()
      ..id = (json['Id'] as num).toInt()
      ..deviceIndex = (json['DeviceIndex'] as num).toInt()
      ..sensorIndex = (json['SensorIndex'] as num).toInt()
      ..sensorType = json['SensorType'] as String;

Map<String, dynamic> _$SensorReadCmdToJson(SensorReadCmd instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'DeviceIndex': instance.deviceIndex,
      'SensorIndex': instance.sensorIndex,
      'SensorType': instance.sensorType,
    };

SensorSubscribeCmd _$SensorSubscribeCmdFromJson(Map<String, dynamic> json) =>
    SensorSubscribeCmd()
      ..id = (json['Id'] as num).toInt()
      ..deviceIndex = (json['DeviceIndex'] as num).toInt();

Map<String, dynamic> _$SensorSubscribeCmdToJson(SensorSubscribeCmd instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'DeviceIndex': instance.deviceIndex,
    };

SensorUnsubscribeCmd _$SensorUnsubscribeCmdFromJson(
        Map<String, dynamic> json) =>
    SensorUnsubscribeCmd()
      ..id = (json['Id'] as num).toInt()
      ..deviceIndex = (json['DeviceIndex'] as num).toInt();

Map<String, dynamic> _$SensorUnsubscribeCmdToJson(
        SensorUnsubscribeCmd instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'DeviceIndex': instance.deviceIndex,
    };

RawReadCmd _$RawReadCmdFromJson(Map<String, dynamic> json) => RawReadCmd()
  ..id = (json['Id'] as num).toInt()
  ..deviceIndex = (json['DeviceIndex'] as num).toInt();

Map<String, dynamic> _$RawReadCmdToJson(RawReadCmd instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'DeviceIndex': instance.deviceIndex,
    };

RawWriteCmd _$RawWriteCmdFromJson(Map<String, dynamic> json) => RawWriteCmd()
  ..id = (json['Id'] as num).toInt()
  ..deviceIndex = (json['DeviceIndex'] as num).toInt();

Map<String, dynamic> _$RawWriteCmdToJson(RawWriteCmd instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'DeviceIndex': instance.deviceIndex,
    };

RawSubscribeCmd _$RawSubscribeCmdFromJson(Map<String, dynamic> json) =>
    RawSubscribeCmd()
      ..id = (json['Id'] as num).toInt()
      ..deviceIndex = (json['DeviceIndex'] as num).toInt();

Map<String, dynamic> _$RawSubscribeCmdToJson(RawSubscribeCmd instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'DeviceIndex': instance.deviceIndex,
    };

RawUnsubscribeCmd _$RawUnsubscribeCmdFromJson(Map<String, dynamic> json) =>
    RawUnsubscribeCmd()
      ..id = (json['Id'] as num).toInt()
      ..deviceIndex = (json['DeviceIndex'] as num).toInt();

Map<String, dynamic> _$RawUnsubscribeCmdToJson(RawUnsubscribeCmd instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'DeviceIndex': instance.deviceIndex,
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
    <String, dynamic>{
      'Id': instance.id,
    };

ServerInfo _$ServerInfoFromJson(Map<String, dynamic> json) => ServerInfo()
  ..id = (json['Id'] as num).toInt()
  ..serverName = json['ServerName'] as String
  ..apiVersionMajor = (json['ApiVersionMajor'] as num).toInt()
  ..apiVersionMinor = (json['ApiVersionMinor'] as num).toInt()
  ..maxPingTime = (json['MaxPingTime'] as num).toInt();

Map<String, dynamic> _$ServerInfoToJson(ServerInfo instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'ServerName': instance.serverName,
      'ApiVersionMajor': instance.apiVersionMajor,
      'ApiVersionMinor': instance.apiVersionMinor,
      'MaxPingTime': instance.maxPingTime,
    };

DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) => DeviceInfo()
  ..deviceIndex = (json['DeviceIndex'] as num).toInt()
  ..deviceName = json['DeviceName'] as String
  ..deviceDisplayName = json['DeviceDisplayName'] as String?
  ..messageTimingGap = (json['MessageTimingGap'] as num?)?.toInt()
  ..deviceFeatures = (json['DeviceFeatures'] as List<dynamic>)
      .map((e) => ClientDeviceFeature.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$DeviceInfoToJson(DeviceInfo instance) =>
    <String, dynamic>{
      'DeviceIndex': instance.deviceIndex,
      'DeviceName': instance.deviceName,
      'DeviceDisplayName': instance.deviceDisplayName,
      'MessageTimingGap': instance.messageTimingGap,
      'DeviceFeatures': instance.deviceFeatures,
    };

DeviceList _$DeviceListFromJson(Map<String, dynamic> json) => DeviceList()
  ..id = (json['Id'] as num).toInt()
  ..devices = (json['Devices'] as List<dynamic>)
      .map((e) => DeviceInfo.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$DeviceListToJson(DeviceList instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Devices': instance.devices,
    };

DeviceAdded _$DeviceAddedFromJson(Map<String, dynamic> json) => DeviceAdded()
  ..id = (json['Id'] as num).toInt()
  ..deviceIndex = (json['DeviceIndex'] as num).toInt()
  ..deviceName = json['DeviceName'] as String
  ..deviceDisplayName = json['DeviceDisplayName'] as String?
  ..messageTimingGap = (json['MessageTimingGap'] as num?)?.toInt()
  ..deviceFeatures = (json['DeviceFeatures'] as List<dynamic>)
      .map((e) => ClientDeviceFeature.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$DeviceAddedToJson(DeviceAdded instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'DeviceIndex': instance.deviceIndex,
      'DeviceName': instance.deviceName,
      if (instance.deviceDisplayName case final value?)
        'DeviceDisplayName': value,
      if (instance.messageTimingGap case final value?)
        'MessageTimingGap': value,
      'DeviceFeatures': instance.deviceFeatures,
    };

DeviceRemoved _$DeviceRemovedFromJson(Map<String, dynamic> json) =>
    DeviceRemoved()
      ..id = (json['Id'] as num).toInt()
      ..deviceIndex = (json['DeviceIndex'] as num).toInt();

Map<String, dynamic> _$DeviceRemovedToJson(DeviceRemoved instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'DeviceIndex': instance.deviceIndex,
    };

SensorReading _$SensorReadingFromJson(Map<String, dynamic> json) =>
    SensorReading()
      ..id = (json['Id'] as num).toInt()
      ..deviceIndex = (json['DeviceIndex'] as num).toInt()
      ..sensorIndex = (json['SensorIndex'] as num).toInt()
      ..sensorType = json['SensorType'] as String
      ..data = (json['Data'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList();

Map<String, dynamic> _$SensorReadingToJson(SensorReading instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'DeviceIndex': instance.deviceIndex,
      'SensorIndex': instance.sensorIndex,
      'SensorType': instance.sensorType,
      'Data': instance.data,
    };

RawReading _$RawReadingFromJson(Map<String, dynamic> json) => RawReading()
  ..id = (json['Id'] as num).toInt()
  ..deviceIndex = (json['DeviceIndex'] as num).toInt();

Map<String, dynamic> _$RawReadingToJson(RawReading instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'DeviceIndex': instance.deviceIndex,
    };

ButtplugServerMessage _$ButtplugServerMessageFromJson(
        Map<String, dynamic> json) =>
    ButtplugServerMessage()
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
      ..deviceAdded = json['DeviceAdded'] == null
          ? null
          : DeviceAdded.fromJson(json['DeviceAdded'] as Map<String, dynamic>)
      ..deviceRemoved = json['DeviceRemoved'] == null
          ? null
          : DeviceRemoved.fromJson(
              json['DeviceRemoved'] as Map<String, dynamic>)
      ..sensorReading = json['SensorReading'] == null
          ? null
          : SensorReading.fromJson(
              json['SensorReading'] as Map<String, dynamic>)
      ..rawReading = json['RawReading'] == null
          ? null
          : RawReading.fromJson(json['RawReading'] as Map<String, dynamic>)
      ..scanningFinished = json['ScanningFinished'] == null
          ? null
          : ScanningFinished.fromJson(
              json['ScanningFinished'] as Map<String, dynamic>);

Map<String, dynamic> _$ButtplugServerMessageToJson(
        ButtplugServerMessage instance) =>
    <String, dynamic>{
      if (instance.ok case final value?) 'Ok': value,
      if (instance.error case final value?) 'Error': value,
      if (instance.serverInfo case final value?) 'ServerInfo': value,
      if (instance.deviceList case final value?) 'DeviceList': value,
      if (instance.deviceAdded case final value?) 'DeviceAdded': value,
      if (instance.deviceRemoved case final value?) 'DeviceRemoved': value,
      if (instance.sensorReading case final value?) 'SensorReading': value,
      if (instance.rawReading case final value?) 'RawReading': value,
      if (instance.scanningFinished case final value?)
        'ScanningFinished': value,
    };

ButtplugClientMessageUnion _$ButtplugClientMessageUnionFromJson(
        Map<String, dynamic> json) =>
    ButtplugClientMessageUnion()
      ..requestServerInfo = json['RequestServerInfo'] == null
          ? null
          : RequestServerInfo.fromJson(
              json['RequestServerInfo'] as Map<String, dynamic>)
      ..requestDeviceList = json['RequestDeviceList'] == null
          ? null
          : RequestDeviceList.fromJson(
              json['RequestDeviceList'] as Map<String, dynamic>)
      ..ping = json['Ping'] == null
          ? null
          : Ping.fromJson(json['Ping'] as Map<String, dynamic>)
      ..startScanning = json['StartScanning'] == null
          ? null
          : StartScanning.fromJson(
              json['StartScanning'] as Map<String, dynamic>)
      ..stopScanning = json['StopScanning'] == null
          ? null
          : StopScanning.fromJson(json['StopScanning'] as Map<String, dynamic>)
      ..stopAllDevices = json['StopAllDevices'] == null
          ? null
          : StopAllDevices.fromJson(
              json['StopAllDevices'] as Map<String, dynamic>)
      ..valueCmd = json['ValueCmd'] == null
          ? null
          : ValueCmd.fromJson(json['ValueCmd'] as Map<String, dynamic>)
      ..valueWithParameterCmd = json['ValueWithParameterCmd'] == null
          ? null
          : ValueWithParameterCmd.fromJson(
              json['ValueWithParameterCmd'] as Map<String, dynamic>)
      ..sensorReadCmd = json['SensorReadCmd'] == null
          ? null
          : SensorReadCmd.fromJson(
              json['SensorReadCmd'] as Map<String, dynamic>)
      ..sensorSubscribeCmd = json['SensorSubscribeCmd'] == null
          ? null
          : SensorSubscribeCmd.fromJson(
              json['SensorSubscribeCmd'] as Map<String, dynamic>)
      ..sensorUnsubscribeCmd = json['SensorUnsubscribeCmd'] == null
          ? null
          : SensorUnsubscribeCmd.fromJson(
              json['SensorUnsubscribeCmd'] as Map<String, dynamic>)
      ..rawReadCmd = json['RawReadCmd'] == null
          ? null
          : RawReadCmd.fromJson(json['RawReadCmd'] as Map<String, dynamic>)
      ..rawWriteCmd = json['RawWriteCmd'] == null
          ? null
          : RawWriteCmd.fromJson(json['RawWriteCmd'] as Map<String, dynamic>)
      ..rawSubscribeCmd = json['RawSubscribeCmd'] == null
          ? null
          : RawSubscribeCmd.fromJson(
              json['RawSubscribeCmd'] as Map<String, dynamic>)
      ..rawUnsubscribeCmd = json['RawUnsubscribeCmd'] == null
          ? null
          : RawUnsubscribeCmd.fromJson(
              json['RawUnsubscribeCmd'] as Map<String, dynamic>);

Map<String, dynamic> _$ButtplugClientMessageUnionToJson(
        ButtplugClientMessageUnion instance) =>
    <String, dynamic>{
      if (instance.requestServerInfo case final value?)
        'RequestServerInfo': value,
      if (instance.requestDeviceList case final value?)
        'RequestDeviceList': value,
      if (instance.ping case final value?) 'Ping': value,
      if (instance.startScanning case final value?) 'StartScanning': value,
      if (instance.stopScanning case final value?) 'StopScanning': value,
      if (instance.stopAllDevices case final value?) 'StopAllDevices': value,
      if (instance.valueCmd case final value?) 'ValueCmd': value,
      if (instance.valueWithParameterCmd case final value?)
        'ValueWithParameterCmd': value,
      if (instance.sensorReadCmd case final value?) 'SensorReadCmd': value,
      if (instance.sensorSubscribeCmd case final value?)
        'SensorSubscribeCmd': value,
      if (instance.sensorUnsubscribeCmd case final value?)
        'SensorUnsubscribeCmd': value,
      if (instance.rawReadCmd case final value?) 'RawReadCmd': value,
      if (instance.rawWriteCmd case final value?) 'RawWriteCmd': value,
      if (instance.rawSubscribeCmd case final value?) 'RawSubscribeCmd': value,
      if (instance.rawUnsubscribeCmd case final value?)
        'RawUnsubscribeCmd': value,
    };
