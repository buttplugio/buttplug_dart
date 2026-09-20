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
  bool _locallyDisconnected = false;

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

  bool get connected => !_locallyDisconnected && _communicator.connected();

  void markDisconnected() {
    _locallyDisconnected = true;
    for (final feature in features.values) {
      feature.markDisconnected();
    }
  }

  void _ensureConnected() {
    if (!connected) {
      throw ButtplugClientDeviceException('$name is disconnected');
    }
  }

  int get messageTimingGap => _messageTimingGap;

  Future<void> runOutput(DeviceOutputCommand cmd) async {
    _ensureConnected();
    final matching = features.values.where((x) => x.hasOutput(cmd.outputType)).toList();
    if (matching.isEmpty) {
      throw ButtplugClientDeviceFeatureCapabilityException(
        '$name does not support ${cmd.outputType} commands',
      );
    }
    await _communicator.sendMessagesExpectOk(
      matching.map((feature) => feature.generateOutputCmd(cmd)).toList(),
    );
  }

  Future<int> battery() async {
    _ensureConnected();
    final batteryFeature = features.values.cast<ButtplugClientDeviceFeature?>().firstWhere(
      (feature) => feature!.feature.input?[InputType.battery]?.command.any(
            (command) => command.toLowerCase() == InputCommand.read.name.toLowerCase(),
          ) ?? false,
      orElse: () => null,
    );
    if (batteryFeature == null) {
      throw ButtplugClientDeviceFeatureCapabilityException(
        '$name does not support readable battery commands',
      );
    }
    final ret = await batteryFeature.readInput(InputType.battery);
    final battery = ret[InputType.battery];
    if (battery == null) {
      throw ButtplugClientDeviceFeatureCapabilityException("Didn't get back battery return: $ret");
    }
    return battery.value;
  }
}
