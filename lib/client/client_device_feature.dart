part of '../buttplug.dart';

class ButtplugClientDeviceFeature {
  final int deviceIndex;
  final ClientDeviceFeature feature;
  final _ButtplugClientCommunicator _communicator;

  ButtplugClientDeviceFeature._(this._communicator, this.deviceIndex, this.feature);

  ValueWithParameterCmd _generateValueWithParameterCmd(ActuatorType featureType, int value, int parameter) {
    if (feature.featureType != featureType.name ||
        feature.actuator == null ||
        !feature.actuator!.messages.contains("ValueWithParameterCmd")) {
      throw ButtplugClientDeviceException("${feature.description} does not support $featureType commands");
    }
    var msg = ValueWithParameterCmd();
    msg.value = value;
    msg.parameter = parameter;
    msg.actuatorType = feature.featureType;
    msg.deviceIndex = deviceIndex;
    msg.featureIndex = feature.featureIndex;
    return msg;
  }

  ValueCmd _generateValueCmd(ActuatorType featureType, int value) {
    if (feature.featureType != featureType.name ||
        feature.actuator == null ||
        !feature.actuator!.messages.contains("ValueCmd")) {
      throw ButtplugClientDeviceException("${feature.description} does not support $featureType commands");
    }
    var msg = ValueCmd();
    msg.value = value;
    msg.actuatorType = feature.featureType;
    msg.deviceIndex = deviceIndex;
    msg.featureIndex = feature.featureIndex;
    return msg;
  }

  Future<List<int>> _sensorRead(SensorType sensorType) async {
    if (feature.sensor == null) {
      throw ButtplugClientDeviceException("${feature.description} does not have a readable sensor");
    }
    var sensorReadMsg = SensorReadCmd();
    sensorReadMsg.deviceIndex = deviceIndex;
    sensorReadMsg.sensorIndex = feature.featureIndex;
    sensorReadMsg.sensorType = SensorType.values.byName(feature.featureType).toString();
    ButtplugServerMessage returnMsg = await _communicator.sendMessageExpectReply(sensorReadMsg);
    if (returnMsg.sensorReading == null) {
      throw ButtplugClientDeviceException("Did not receive SensorReading back from SensorRead transaction");
    }
    return returnMsg.sensorReading!.data;
  }

  Future<void> _runValueCmd(ActuatorType actuator, int value) async {
    await _communicator.sendMessageExpectOk(_generateValueCmd(actuator, value));
  }

  Future<void> _runValueWithParameterCmd(ActuatorType actuator, int value, int parameter) async {
    await _communicator.sendMessageExpectOk(_generateValueWithParameterCmd(actuator, value, parameter));
  }

  Future<void> vibrate(int speed) async {
    await _runValueCmd(ActuatorType.Vibrate, speed);
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
    var levels = await _sensorRead(SensorType.Battery);
    return levels[0];
  }
}
