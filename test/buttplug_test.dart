import 'dart:convert';

import 'package:buttplug/buttplug.dart';
import 'package:buttplug/messages/messages.dart';
import 'package:test/test.dart';

void main() {
  group('Message de/serialization', () {
    setUp(() {
      // Additional setup goes here.
    });

    /*
    test('Message Union Formatting', () {
      var ok = Ok();
      ok.id = 5;
      var serverOk = ButtplugServerMessage();
      serverOk.ok = ok;
      var jsonString = jsonEncode(serverOk);
      expect(jsonString, equals('{"Ok":{"Id":5}}'));
    });
*/
    test('Device List Deserialization', () {
      var incoming =
          '[{"DeviceList":{"Id":2,"Devices":{"0":{"DeviceIndex":0,"DeviceName":"Lovense Ridge","DeviceMessageTimingGap":100,"DeviceFeatures":{"0":{"FeatureIndex":0,"FeatureDescription":"","Output":{"Vibrate":{"Value":[0,20]}}},"1":{"FeatureIndex":1,"FeatureDescription":"","Output":{"Rotate":{"Value":[-20,20]}}},"2":{"FeatureIndex":2,"FeatureDescription":"battery Level","Input":{"Battery":{"ValueRange":[[0,100]],"InputCommands":["Read"]}}}}}}}}]';
      List<dynamic> messageList = jsonDecode(incoming);
      var message = ButtplugServerMessage.fromJson(messageList[0]);
      expect(message.deviceList, isNotNull);
      var deviceAdded = message.deviceList!.devices[0]!;
      expect(deviceAdded.deviceName, equals("Lovense Ridge"));
    });
    /*
    test('Handle deserializing list of Buttplug Server Messages', () {
      var incoming = '[{"Ok": {"Id":5}}]';
      List<dynamic> msgs = jsonDecode(incoming);
      for (var msg in msgs) {
        var message = ButtplugServerMessage.fromJson(msg);
        expect(message.ok, isNotNull);
        expect(message.ok!.id, equals(5));
      }
    });
      */
  });
}
