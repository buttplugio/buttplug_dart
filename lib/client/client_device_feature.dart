import 'package:buttplug/buttplug.dart';
import 'package:loggy/loggy.dart';

class ButtplugClientDeviceFeature {
  final int deviceIndex;
  final ClientDeviceFeature feature;
  final ButtplugClientCommunicator _communicator;

  ButtplugClientDeviceFeature(this._communicator, this.deviceIndex, this.feature);

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

    if (type == OutputType.hwPositionWithDuration) {
      if (command.duration == null) {
        throw "hwPositionWithDuration requires position defined";
      }
      newCommand.duration = command.duration;
    }
    var p = command.value;
    if (p.percent == null) {
      // TODO Check step limits here
      newCommand.value = command.value.steps;
    } else {
      newCommand.value = (feature.output![type]!.value![1] * p.percent!).ceil();
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

  Future<Map<InputType, InputDataType>> readInput(InputType inputType) async {
    if (feature.input == null) {
      throw ButtplugClientDeviceException("${feature.featureDescription} does not have a readable input");
    }
    logInfo(feature.input!);
    if (!feature.input!.containsKey(inputType)) {
      throw ButtplugClientDeviceException("${feature.featureDescription} does not have input type $inputType");
    }
    var sensorReadMsg = InputCmd();
    sensorReadMsg.deviceIndex = deviceIndex;
    sensorReadMsg.featureIndex = feature.featureIndex;
    sensorReadMsg.type = inputType;
    sensorReadMsg.command = InputCommand.read;
    ButtplugServerMessage returnMsg = await _communicator.sendMessageExpectReply(sensorReadMsg);
    if (returnMsg.inputReading == null) {
      throw ButtplugClientDeviceException("Did not receive InputReading back from InputCmd transaction");
    }
    return returnMsg.inputReading!.reading;
  }
}
