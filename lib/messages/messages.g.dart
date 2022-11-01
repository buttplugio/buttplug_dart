// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientGenericDeviceMessageAttributes
    _$ClientGenericDeviceMessageAttributesFromJson(Map<String, dynamic> json) =>
        ClientGenericDeviceMessageAttributes()
          ..featureDescriptor = json['FeatureDescriptor'] as String
          ..actuatorType =
              $enumDecode(_$ActuatorTypeEnumMap, json['ActuatorType'])
          ..stepCount = json['StepCount'] as int;

Map<String, dynamic> _$ClientGenericDeviceMessageAttributesToJson(
        ClientGenericDeviceMessageAttributes instance) =>
    <String, dynamic>{
      'FeatureDescriptor': instance.featureDescriptor,
      'ActuatorType': _$ActuatorTypeEnumMap[instance.actuatorType]!,
      'StepCount': instance.stepCount,
    };

const _$ActuatorTypeEnumMap = {
  ActuatorType.Vibrate: 'Vibrate',
  ActuatorType.Rotate: 'Rotate',
  ActuatorType.Oscillate: 'Oscillate',
  ActuatorType.Constrict: 'Constrict',
  ActuatorType.Inflate: 'Inflate',
  ActuatorType.Position: 'Position',
};

SensorDeviceMessageAttributes _$SensorDeviceMessageAttributesFromJson(
        Map<String, dynamic> json) =>
    SensorDeviceMessageAttributes()
      ..featureDescriptor = json['FeatureDescriptor'] as String
      ..sensorType = $enumDecode(_$SensorTypeEnumMap, json['SensorType'])
      ..stepCount =
          (json['StepCount'] as List<dynamic>).map((e) => e as int).toList();

Map<String, dynamic> _$SensorDeviceMessageAttributesToJson(
        SensorDeviceMessageAttributes instance) =>
    <String, dynamic>{
      'FeatureDescriptor': instance.featureDescriptor,
      'SensorType': _$SensorTypeEnumMap[instance.sensorType]!,
      'StepCount': instance.stepCount,
    };

const _$SensorTypeEnumMap = {
  SensorType.Battery: 'Battery',
  SensorType.RSSI: 'RSSI',
  SensorType.Button: 'Button',
  SensorType.Pressure: 'Pressure',
  SensorType.Temperature: 'Temperature',
};

NullDeviceMessageAttributes _$NullDeviceMessageAttributesFromJson(
        Map<String, dynamic> json) =>
    NullDeviceMessageAttributes();

Map<String, dynamic> _$NullDeviceMessageAttributesToJson(
        NullDeviceMessageAttributes instance) =>
    <String, dynamic>{};

RawDeviceMessageAttributes _$RawDeviceMessageAttributesFromJson(
        Map<String, dynamic> json) =>
    RawDeviceMessageAttributes()
      ..endpoints = (json['Endpoints'] as List<dynamic>)
          .map((e) => $enumDecode(_$EndpointEnumMap, e))
          .toList();

Map<String, dynamic> _$RawDeviceMessageAttributesToJson(
        RawDeviceMessageAttributes instance) =>
    <String, dynamic>{
      'Endpoints':
          instance.endpoints.map((e) => _$EndpointEnumMap[e]!).toList(),
    };

const _$EndpointEnumMap = {
  Endpoint.Command: 'Command',
  Endpoint.Firmware: 'Firmware',
  Endpoint.Rx: 'Rx',
  Endpoint.RxAccel: 'RxAccel',
  Endpoint.RxBLEBattery: 'RxBLEBattery',
  Endpoint.RxBLEModel: 'RxBLEModel',
  Endpoint.RxPressure: 'RxPressure',
  Endpoint.RxTouch: 'RxTouch',
  Endpoint.Tx: 'Tx',
  Endpoint.TxMode: 'TxMode',
  Endpoint.TxShock: 'TxShock',
  Endpoint.TxVibrate: 'TxVibrate',
  Endpoint.TxVendorControl: 'TxVendorControl',
  Endpoint.Whitelist: 'Whitelist',
  Endpoint.Generic0: 'Generic0',
  Endpoint.Generic1: 'Generic1',
  Endpoint.Generic2: 'Generic2',
  Endpoint.Generic3: 'Generic3',
  Endpoint.Generic4: 'Generic4',
  Endpoint.Generic5: 'Generic5',
  Endpoint.Generic6: 'Generic6',
  Endpoint.Generic7: 'Generic7',
  Endpoint.Generic8: 'Generic8',
  Endpoint.Generic9: 'Generic9',
  Endpoint.Generic10: 'Generic10',
  Endpoint.Generic11: 'Generic11',
  Endpoint.Generic12: 'Generic12',
  Endpoint.Generic13: 'Generic13',
  Endpoint.Generic14: 'Generic14',
  Endpoint.Generic15: 'Generic15',
  Endpoint.Generic16: 'Generic16',
  Endpoint.Generic17: 'Generic17',
  Endpoint.Generic18: 'Generic18',
  Endpoint.Generic19: 'Generic19',
  Endpoint.Generic20: 'Generic20',
  Endpoint.Generic21: 'Generic21',
  Endpoint.Generic22: 'Generic22',
  Endpoint.Generic23: 'Generic23',
  Endpoint.Generic24: 'Generic24',
  Endpoint.Generic25: 'Generic25',
  Endpoint.Generic26: 'Generic26',
  Endpoint.Generic27: 'Generic27',
  Endpoint.Generic28: 'Generic28',
  Endpoint.Generic29: 'Generic29',
  Endpoint.Generic30: 'Generic30',
  Endpoint.Generic31: 'Generic31',
};

ClientDeviceMessageAttributes _$ClientDeviceMessageAttributesFromJson(
        Map<String, dynamic> json) =>
    ClientDeviceMessageAttributes()
      ..scalarCmd = (json['ScalarCmd'] as List<dynamic>?)
          ?.map((e) => ClientGenericDeviceMessageAttributes.fromJson(
              e as Map<String, dynamic>))
          .toList()
      ..rotateCmd = (json['RotateCmd'] as List<dynamic>?)
          ?.map((e) => ClientGenericDeviceMessageAttributes.fromJson(
              e as Map<String, dynamic>))
          .toList()
      ..linearCmd = (json['LinearCmd'] as List<dynamic>?)
          ?.map((e) => ClientGenericDeviceMessageAttributes.fromJson(
              e as Map<String, dynamic>))
          .toList()
      ..sensorReadCmd = (json['SensorReadCmd'] as List<dynamic>?)
          ?.map((e) =>
              SensorDeviceMessageAttributes.fromJson(e as Map<String, dynamic>))
          .toList()
      ..sensorSubscribeCmd = (json['SensorSubscribeCmd'] as List<dynamic>?)
          ?.map((e) =>
              SensorDeviceMessageAttributes.fromJson(e as Map<String, dynamic>))
          .toList()
      ..stopDeviceCmd = NullDeviceMessageAttributes.fromJson(
          json['StopDeviceCmd'] as Map<String, dynamic>)
      ..rawReadCmd = (json['RawReadCmd'] as List<dynamic>?)
          ?.map((e) =>
              RawDeviceMessageAttributes.fromJson(e as Map<String, dynamic>))
          .toList()
      ..rawWriteCmd = (json['RawWriteCmd'] as List<dynamic>?)
          ?.map((e) =>
              RawDeviceMessageAttributes.fromJson(e as Map<String, dynamic>))
          .toList()
      ..rawSubscribeCmd = (json['RawSubscribeCmd'] as List<dynamic>?)
          ?.map((e) =>
              RawDeviceMessageAttributes.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$ClientDeviceMessageAttributesToJson(
    ClientDeviceMessageAttributes instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ScalarCmd', instance.scalarCmd);
  writeNotNull('RotateCmd', instance.rotateCmd);
  writeNotNull('LinearCmd', instance.linearCmd);
  writeNotNull('SensorReadCmd', instance.sensorReadCmd);
  writeNotNull('SensorSubscribeCmd', instance.sensorSubscribeCmd);
  val['StopDeviceCmd'] = instance.stopDeviceCmd;
  writeNotNull('RawReadCmd', instance.rawReadCmd);
  writeNotNull('RawWriteCmd', instance.rawWriteCmd);
  writeNotNull('RawSubscribeCmd', instance.rawSubscribeCmd);
  return val;
}

RequestServerInfo _$RequestServerInfoFromJson(Map<String, dynamic> json) =>
    RequestServerInfo()
      ..id = json['Id'] as int
      ..clientName = json['ClientName'] as String
      ..messageVersion = json['MessageVersion'] as int;

Map<String, dynamic> _$RequestServerInfoToJson(RequestServerInfo instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'ClientName': instance.clientName,
      'MessageVersion': instance.messageVersion,
    };

Ping _$PingFromJson(Map<String, dynamic> json) =>
    Ping()..id = json['Id'] as int;

Map<String, dynamic> _$PingToJson(Ping instance) => <String, dynamic>{
      'Id': instance.id,
    };

RequestDeviceList _$RequestDeviceListFromJson(Map<String, dynamic> json) =>
    RequestDeviceList()..id = json['Id'] as int;

Map<String, dynamic> _$RequestDeviceListToJson(RequestDeviceList instance) =>
    <String, dynamic>{
      'Id': instance.id,
    };

StartScanning _$StartScanningFromJson(Map<String, dynamic> json) =>
    StartScanning()..id = json['Id'] as int;

Map<String, dynamic> _$StartScanningToJson(StartScanning instance) =>
    <String, dynamic>{
      'Id': instance.id,
    };

StopScanning _$StopScanningFromJson(Map<String, dynamic> json) =>
    StopScanning()..id = json['Id'] as int;

Map<String, dynamic> _$StopScanningToJson(StopScanning instance) =>
    <String, dynamic>{
      'Id': instance.id,
    };

ScalarCmd _$ScalarCmdFromJson(Map<String, dynamic> json) => ScalarCmd()
  ..id = json['Id'] as int
  ..deviceIndex = json['DeviceIndex'] as int;

Map<String, dynamic> _$ScalarCmdToJson(ScalarCmd instance) => <String, dynamic>{
      'Id': instance.id,
      'DeviceIndex': instance.deviceIndex,
    };

RotateCmd _$RotateCmdFromJson(Map<String, dynamic> json) => RotateCmd()
  ..id = json['Id'] as int
  ..deviceIndex = json['DeviceIndex'] as int;

Map<String, dynamic> _$RotateCmdToJson(RotateCmd instance) => <String, dynamic>{
      'Id': instance.id,
      'DeviceIndex': instance.deviceIndex,
    };

LinearCmd _$LinearCmdFromJson(Map<String, dynamic> json) => LinearCmd()
  ..id = json['Id'] as int
  ..deviceIndex = json['DeviceIndex'] as int;

Map<String, dynamic> _$LinearCmdToJson(LinearCmd instance) => <String, dynamic>{
      'Id': instance.id,
      'DeviceIndex': instance.deviceIndex,
    };

SensorReadCmd _$SensorReadCmdFromJson(Map<String, dynamic> json) =>
    SensorReadCmd()
      ..id = json['Id'] as int
      ..deviceIndex = json['DeviceIndex'] as int;

Map<String, dynamic> _$SensorReadCmdToJson(SensorReadCmd instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'DeviceIndex': instance.deviceIndex,
    };

SensorSubscribeCmd _$SensorSubscribeCmdFromJson(Map<String, dynamic> json) =>
    SensorSubscribeCmd()
      ..id = json['Id'] as int
      ..deviceIndex = json['DeviceIndex'] as int;

Map<String, dynamic> _$SensorSubscribeCmdToJson(SensorSubscribeCmd instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'DeviceIndex': instance.deviceIndex,
    };

SensorUnsubscribeCmd _$SensorUnsubscribeCmdFromJson(
        Map<String, dynamic> json) =>
    SensorUnsubscribeCmd()
      ..id = json['Id'] as int
      ..deviceIndex = json['DeviceIndex'] as int;

Map<String, dynamic> _$SensorUnsubscribeCmdToJson(
        SensorUnsubscribeCmd instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'DeviceIndex': instance.deviceIndex,
    };

RawReadCmd _$RawReadCmdFromJson(Map<String, dynamic> json) => RawReadCmd()
  ..id = json['Id'] as int
  ..deviceIndex = json['DeviceIndex'] as int;

Map<String, dynamic> _$RawReadCmdToJson(RawReadCmd instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'DeviceIndex': instance.deviceIndex,
    };

RawWriteCmd _$RawWriteCmdFromJson(Map<String, dynamic> json) => RawWriteCmd()
  ..id = json['Id'] as int
  ..deviceIndex = json['DeviceIndex'] as int;

Map<String, dynamic> _$RawWriteCmdToJson(RawWriteCmd instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'DeviceIndex': instance.deviceIndex,
    };

RawSubscribeCmd _$RawSubscribeCmdFromJson(Map<String, dynamic> json) =>
    RawSubscribeCmd()
      ..id = json['Id'] as int
      ..deviceIndex = json['DeviceIndex'] as int;

Map<String, dynamic> _$RawSubscribeCmdToJson(RawSubscribeCmd instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'DeviceIndex': instance.deviceIndex,
    };

RawUnsubscribeCmd _$RawUnsubscribeCmdFromJson(Map<String, dynamic> json) =>
    RawUnsubscribeCmd()
      ..id = json['Id'] as int
      ..deviceIndex = json['DeviceIndex'] as int;

Map<String, dynamic> _$RawUnsubscribeCmdToJson(RawUnsubscribeCmd instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'DeviceIndex': instance.deviceIndex,
    };

Ok _$OkFromJson(Map<String, dynamic> json) => Ok()..id = json['Id'] as int;

Map<String, dynamic> _$OkToJson(Ok instance) => <String, dynamic>{
      'Id': instance.id,
    };

Error _$ErrorFromJson(Map<String, dynamic> json) => Error()
  ..id = json['Id'] as int
  ..errorCode = json['ErrorCode'] as int
  ..errorMessage = json['ErrorMessage'] as String;

Map<String, dynamic> _$ErrorToJson(Error instance) => <String, dynamic>{
      'Id': instance.id,
      'ErrorCode': instance.errorCode,
      'ErrorMessage': instance.errorMessage,
    };

ScanningFinished _$ScanningFinishedFromJson(Map<String, dynamic> json) =>
    ScanningFinished()..id = json['Id'] as int;

Map<String, dynamic> _$ScanningFinishedToJson(ScanningFinished instance) =>
    <String, dynamic>{
      'Id': instance.id,
    };

ServerInfo _$ServerInfoFromJson(Map<String, dynamic> json) => ServerInfo()
  ..id = json['Id'] as int
  ..serverName = json['ServerName'] as String
  ..messageVersion = json['MessageVersion'] as int
  ..maxPingTime = json['MaxPingTime'] as int;

Map<String, dynamic> _$ServerInfoToJson(ServerInfo instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'ServerName': instance.serverName,
      'MessageVersion': instance.messageVersion,
      'MaxPingTime': instance.maxPingTime,
    };

DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) => DeviceInfo()
  ..deviceIndex = json['DeviceIndex'] as int
  ..deviceName = json['DeviceName'] as String
  ..deviceDisplayName = json['DeviceDisplayName'] as String?
  ..messageTimingGap = json['MessageTimingGap'] as int?
  ..deviceMessages = ClientDeviceMessageAttributes.fromJson(
      json['DeviceMessages'] as Map<String, dynamic>);

Map<String, dynamic> _$DeviceInfoToJson(DeviceInfo instance) =>
    <String, dynamic>{
      'DeviceIndex': instance.deviceIndex,
      'DeviceName': instance.deviceName,
      'DeviceDisplayName': instance.deviceDisplayName,
      'MessageTimingGap': instance.messageTimingGap,
      'DeviceMessages': instance.deviceMessages,
    };

DeviceList _$DeviceListFromJson(Map<String, dynamic> json) => DeviceList()
  ..id = json['Id'] as int
  ..devices = (json['Devices'] as List<dynamic>)
      .map((e) => DeviceInfo.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$DeviceListToJson(DeviceList instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Devices': instance.devices,
    };

DeviceAdded _$DeviceAddedFromJson(Map<String, dynamic> json) => DeviceAdded()
  ..id = json['Id'] as int
  ..deviceIndex = json['DeviceIndex'] as int
  ..deviceName = json['DeviceName'] as String
  ..deviceDisplayName = json['DeviceDisplayName'] as String?
  ..messageTimingGap = json['MessageTimingGap'] as int?
  ..deviceMessages = ClientDeviceMessageAttributes.fromJson(
      json['DeviceMessages'] as Map<String, dynamic>);

Map<String, dynamic> _$DeviceAddedToJson(DeviceAdded instance) {
  final val = <String, dynamic>{
    'Id': instance.id,
    'DeviceIndex': instance.deviceIndex,
    'DeviceName': instance.deviceName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('DeviceDisplayName', instance.deviceDisplayName);
  writeNotNull('MessageTimingGap', instance.messageTimingGap);
  val['DeviceMessages'] = instance.deviceMessages;
  return val;
}

DeviceRemoved _$DeviceRemovedFromJson(Map<String, dynamic> json) =>
    DeviceRemoved()
      ..id = json['Id'] as int
      ..deviceIndex = json['DeviceIndex'] as int;

Map<String, dynamic> _$DeviceRemovedToJson(DeviceRemoved instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'DeviceIndex': instance.deviceIndex,
    };

SensorReading _$SensorReadingFromJson(Map<String, dynamic> json) =>
    SensorReading()
      ..id = json['Id'] as int
      ..deviceIndex = json['DeviceIndex'] as int;

Map<String, dynamic> _$SensorReadingToJson(SensorReading instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'DeviceIndex': instance.deviceIndex,
    };

RawReading _$RawReadingFromJson(Map<String, dynamic> json) => RawReading()
  ..id = json['Id'] as int
  ..deviceIndex = json['DeviceIndex'] as int;

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
          : RawReading.fromJson(json['RawReading'] as Map<String, dynamic>);

Map<String, dynamic> _$ButtplugServerMessageToJson(
    ButtplugServerMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Ok', instance.ok);
  writeNotNull('ServerInfo', instance.serverInfo);
  writeNotNull('DeviceList', instance.deviceList);
  writeNotNull('DeviceAdded', instance.deviceAdded);
  writeNotNull('DeviceRemoved', instance.deviceRemoved);
  writeNotNull('SensorReading', instance.sensorReading);
  writeNotNull('RawReading', instance.rawReading);
  return val;
}

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
      ..scalarCmd = json['ScalarCmd'] == null
          ? null
          : ScalarCmd.fromJson(json['ScalarCmd'] as Map<String, dynamic>)
      ..rotateCmd = json['RotateCmd'] == null
          ? null
          : RotateCmd.fromJson(json['RotateCmd'] as Map<String, dynamic>)
      ..linearCmd = json['LinearCmd'] == null
          ? null
          : LinearCmd.fromJson(json['LinearCmd'] as Map<String, dynamic>)
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
    ButtplugClientMessageUnion instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('RequestServerInfo', instance.requestServerInfo);
  writeNotNull('RequestDeviceList', instance.requestDeviceList);
  writeNotNull('Ping', instance.ping);
  writeNotNull('StartScanning', instance.startScanning);
  writeNotNull('StopScanning', instance.stopScanning);
  writeNotNull('ScalarCmd', instance.scalarCmd);
  writeNotNull('RotateCmd', instance.rotateCmd);
  writeNotNull('LinearCmd', instance.linearCmd);
  writeNotNull('SensorReadCmd', instance.sensorReadCmd);
  writeNotNull('SensorSubscribeCmd', instance.sensorSubscribeCmd);
  writeNotNull('SensorUnsubscribeCmd', instance.sensorUnsubscribeCmd);
  writeNotNull('RawReadCmd', instance.rawReadCmd);
  writeNotNull('RawWriteCmd', instance.rawWriteCmd);
  writeNotNull('RawSubscribeCmd', instance.rawSubscribeCmd);
  writeNotNull('RawUnsubscribeCmd', instance.rawUnsubscribeCmd);
  return val;
}
