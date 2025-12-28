import 'package:buttplug/buttplug.dart';

class ButtplugClientDeviceFeature {
  final int deviceIndex;
  final ClientDeviceFeature feature;
  final ButtplugClientCommunicator _communicator;

  ButtplugClientDeviceFeature(this._communicator, this.deviceIndex, this.feature);

  /*
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
  */

  void _isOutputValid(OutputType type) {
    if (feature.output != null && !feature.output!.containsKey(type)) {
      throw "Feature index ${feature.featureIndex} does not support type $type for device";
    }
  }

  OutputCmd generateOutputCmd(DeviceOutputCommand command) {
    ClientDeviceFeatureOutput newCommand = ClientDeviceFeatureOutput();
    // Make sure the requested feature is valid
    _isOutputValid(command.outputType);

    var type = command.outputType;

    if (type == OutputType.positionWithDuration) {
      if (command.position == null) {
        throw "PositionWithDuration requires position defined";
      }
      var p = command.position;
      if (p != null && p.percent == null) {
        newCommand.position = command.position!.steps;
      } else {
        newCommand.position = (feature.output![type]!.position![1] * p!.percent!).ceil();
      }
      if (type == OutputType.positionWithDuration) {
        if (command.duration == null) {
          throw "PositionWithDuration requires duration defined";
        }
        newCommand.duration = command.duration;
      }
    } else {
      if (command.value == null) {
        throw "$type requires value defined";
      }
      var p = command.value;
      if (p!.percent == null) {
        // TODO Check step limits here
        newCommand.value = command.value!.steps;
      } else {
        newCommand.value = (feature.output![type]!.value![1] * p.percent!).ceil();
      }
    }
    var msg = OutputCmd();
    msg.command[type] = newCommand;
    msg.deviceIndex = deviceIndex;
    msg.featureIndex = feature.featureIndex;
    return msg;
  }

  bool hasOutput(OutputType type) {
    if (feature.output != null) {
      return feature.output!.containsKey(type);
    }
    return false;
  }

  Future<void> runOutput(DeviceOutputCommand cmd) async {
    await _communicator.sendMessageExpectOk(generateOutputCmd(cmd));
  }
}
