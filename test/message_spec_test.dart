import 'dart:convert';

import 'package:buttplug/buttplug.dart';
import 'package:test/test.dart';

void main() {
  group('StopCmd message specification', () {
    test('serializes a stop command with all selectors', () {
      final stop = StopCmd()
        ..id = 1
        ..deviceIndex = 0
        ..featureIndex = 0
        ..inputs = true
        ..outputs = true;

      expect(jsonEncode({'StopCmd': stop}), equals(
        '{"StopCmd":{"Id":1,"DeviceIndex":0,"FeatureIndex":0,"Inputs":true,"Outputs":true}}',
      ));
    });

    test('serializes a stop-all command without an obsolete Command field', () {
      final stop = StopCmd()..id = 2;

      expect(stop.toJson(), equals({'Id': 2}));
    });

    test('deserializes a stop command from the specification shape', () {
      final stop = StopCmd.fromJson({
        'Id': 1,
        'DeviceIndex': 0,
        'FeatureIndex': 0,
        'Inputs': true,
        'Outputs': true,
      });

      expect(stop.id, equals(1));
      expect(stop.deviceIndex, equals(0));
      expect(stop.featureIndex, equals(0));
      expect(stop.inputs, isTrue);
      expect(stop.outputs, isTrue);
    });
  });
}
