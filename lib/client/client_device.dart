import 'package:buttplug/client/client.dart';
import 'package:buttplug/client/client_communicator.dart';
import 'package:buttplug/client/client_device_command.dart';
import 'package:buttplug/client/client_device_feature.dart';
import 'package:buttplug/messages/messages.dart';

class ButtplugClientDevice {
  late final int index;
  late final String name;
  late final String? displayName;
  late final int _messageTimingGap;
  late final Map<int, ButtplugClientDeviceFeature> features;
  final ButtplugClientCommunicator _communicator;

  ButtplugClientDevice(DeviceInfo deviceInfo, this._communicator) {
    index = deviceInfo.deviceIndex;
    name = deviceInfo.deviceName;
    displayName = deviceInfo.deviceDisplayName;
    _messageTimingGap = deviceInfo.deviceMessageTimingGap ?? 0;
    features = {
      for (var v in deviceInfo.deviceFeatures.values)
        v.featureIndex: ButtplugClientDeviceFeature(_communicator, index, v),
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
        .map((x) => x.generateOutputCmd(cmd))
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
