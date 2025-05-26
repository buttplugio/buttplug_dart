part of '../buttplug.dart';

class ButtplugClientDevice {
  late final int index;
  late final String name;
  late final String? displayName;
  late final int _messageTimingGap;
  late final List<ButtplugClientDeviceFeature> features;
  final _ButtplugClientCommunicator _communicator;

  ButtplugClientDevice._(DeviceInfo deviceInfo, this._communicator) {
    index = deviceInfo.deviceIndex;
    name = deviceInfo.deviceName;
    displayName = deviceInfo.deviceDisplayName;
    _messageTimingGap = deviceInfo.messageTimingGap ?? 0;
    features = deviceInfo.deviceFeatures.map((x) => ButtplugClientDeviceFeature._(_communicator, index, x)).toList();
  }

  bool get connected {
    return true;
  }

  int get messageTimingGap {
    return _messageTimingGap;
  }

  Future<void> _runValueCmd(ActuatorType actuator, int value) async {
    var msgs = features
        .where((x) => x.feature.featureType == actuator.name)
        .map((x) => x._generateValueCmd(actuator, value))
        .toList();
    if (msgs.isEmpty) {
      throw ButtplugClientDeviceException("$name does not support $actuator commands");
    }
    await _communicator.sendMessagesExpectOk(msgs);
  }

  Future<void> _runValueWithParameterCmd(ActuatorType actuator, int value, int parameter) async {
    var msgs = features
        .where((x) => x.feature.featureType == actuator.name)
        .map((x) => x._generateValueWithParameterCmd(actuator, value, parameter))
        .toList();
    if (msgs.isEmpty) {
      throw ButtplugClientDeviceException("$name does not support $actuator commands");
    }
    await _communicator.sendMessagesExpectOk(msgs);
  }

  Future<void> vibrate(int speed) async {
    _runValueCmd(ActuatorType.Vibrate, speed);
  }

  Future<void> oscillate(int speed) async {
    await _runValueCmd(ActuatorType.Oscillate, speed);
  }

  Future<void> rotate(int speed) async {
    await _runValueCmd(ActuatorType.Rotate, speed);
  }

  Future<void> constrict(int level) async {
    await _runValueCmd(ActuatorType.Constrict, level);
  }

  Future<void> inflate(int level) async {
    await _runValueCmd(ActuatorType.Inflate, level);
  }

  Future<void> position(int position) async {
    await _runValueCmd(ActuatorType.Position, position);
  }

  Future<void> positionWithDuration(int position, int duration) async {
    await _runValueWithParameterCmd(ActuatorType.PositionWithDuration, position, duration);
  }

  Future<void> rotateWithDirection(int speed, bool clockwise) async {
    await _runValueWithParameterCmd(ActuatorType.RotateWithDirection, speed, clockwise ? 1 : 0);
  }

  Future<int> battery() async {
    var msgs =
        features.where((x) => x.feature.featureType == SensorType.Battery.toString()).map((x) => x.battery()).toList();
    if (msgs.isEmpty) {
      throw ButtplugClientDeviceException("$name does not support battery commands");
    }
    return await msgs[0];
  }
}
