import 'dart:convert';

import 'package:buttplug/buttplug.dart';
import 'package:test/test.dart';

void main() {
  group('Message de/serialization', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('Message Union Formatting', () {
      var ok = Ok();
      ok.id = 5;
      var serverOk = ButtplugServerMessage();
      serverOk.ok = ok;
      var jsonString = jsonEncode(serverOk);
      expect(jsonString, equals('{"Ok":{"Id":5}}'));
    });

    test('Device Added Deserialization', () {
      var incoming =
          '[{"DeviceAdded":{"Id":0,"DeviceIndex":0,"DeviceName":"OhMiBod Lumen","DeviceMessages":{"ScalarCmd":[{"FeatureDescriptor":"No description available for feature","ActuatorType":"Vibrate","StepCount":100}],"StopDeviceCmd":{}}}}]';
      List<dynamic> messageList = jsonDecode(incoming);
      var message = ButtplugServerMessage.fromJson(messageList[0]);
      expect(message.deviceAdded, isNotNull);
      expect(message.deviceAdded!.deviceName, equals("OhMiBod Lumen"));
      expect(message.deviceAdded!.deviceMessages.scalarCmd, isNotNull);
      expect(message.deviceAdded!.deviceMessages.stopDeviceCmd, isNotNull);
      expect(message.deviceAdded!.deviceMessages.linearCmd, isNull);
      expect(message.deviceAdded!.deviceMessages.scalarCmd!.length, equals(1));
      expect(message.deviceAdded!.deviceMessages.scalarCmd![0].actuatorType, equals(ActuatorType.Vibrate));
    });

    test('Device List Deserialization', () {
      var incoming =
          '[{"DeviceList":{"Id":2,"Devices":[{"DeviceIndex":0,"DeviceName":"OhMiBod Lumen","DeviceMessages":{"ScalarCmd":[{"FeatureDescriptor":"No description available for feature","ActuatorType":"Vibrate","StepCount":100}],"StopDeviceCmd":{}}}]}}]';
      List<dynamic> messageList = jsonDecode(incoming);
      var message = ButtplugServerMessage.fromJson(messageList[0]);
      expect(message.deviceList, isNotNull);
      var deviceAdded = message.deviceList!.devices[0];
      expect(deviceAdded.deviceName, equals("OhMiBod Lumen"));
      expect(deviceAdded.deviceMessages.scalarCmd, isNotNull);
      expect(deviceAdded.deviceMessages.stopDeviceCmd, isNotNull);
      expect(deviceAdded.deviceMessages.linearCmd, isNull);
      expect(deviceAdded.deviceMessages.scalarCmd!.length, equals(1));
      expect(deviceAdded.deviceMessages.scalarCmd![0].actuatorType, equals(ActuatorType.Vibrate));
    });

    test('Handle deserializing list of Buttplug Server Messages', () {
      var incoming = '[{"Ok": {"Id":5}}]';
      List<dynamic> msgs = jsonDecode(incoming);
      for (var msg in msgs) {
        var message = ButtplugServerMessage.fromJson(msg);
        expect(message.ok, isNotNull);
        expect(message.ok!.id, equals(5));
      }
    });
  });
}
