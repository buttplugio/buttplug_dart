part of '../buttplug.dart';

class ButtplugClientDevice {
  late final int index;
  late final String name;
  late final String? displayName;
  late final int _messageTimingGap;
  late final Map<int, ButtplugClientDeviceFeature> features;
  final _ButtplugClientCommunicator _communicator;

  ButtplugClientDevice._(DeviceInfo deviceInfo, this._communicator) {
    index = deviceInfo.deviceIndex;
    name = deviceInfo.deviceName;
    displayName = deviceInfo.deviceDisplayName;
    _messageTimingGap = deviceInfo.deviceMessageTimingGap ?? 0;
    features = {
      for (var v in deviceInfo.deviceFeatures.values)
        v.featureIndex: ButtplugClientDeviceFeature._(_communicator, index, v),
    };
  }

  bool get connected {
    return true;
  }

  int get messageTimingGap {
    return _messageTimingGap;
  }

  Future<void> runOutput(DeviceOutputCommand cmd) async {
    var msgs = features.values
        .where((x) => x.feature.output != null && x.feature.output!.containsKey(cmd.outputType))
        .map((x) => x._generateOutputCmd(cmd))
        .toList();
    if (msgs.isEmpty) {
      throw ButtplugClientDeviceException("$name does not support ${cmd.outputType} commands");
    }
    await _communicator.sendMessagesExpectOk(msgs);
  }

  /*
  Future<int> battery() async {

    var msgs = features
        .where((x) => x.feature.featureType == SensorType.Battery.toString())
        .map((x) => x.battery())
        .toList();
    if (msgs.isEmpty) {
      throw ButtplugClientDeviceException("$name does not support battery commands");
    }
    return await msgs[0];

  }
  */
}
