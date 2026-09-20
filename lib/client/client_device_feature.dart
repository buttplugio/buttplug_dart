import 'package:buttplug/buttplug.dart';

class ButtplugClientDeviceFeatureCapabilityException extends ButtplugClientDeviceException {
  ButtplugClientDeviceFeatureCapabilityException(super.message);
}

class ButtplugClientDeviceFeatureRangeException extends ButtplugClientDeviceException {
  ButtplugClientDeviceFeatureRangeException(super.message);
}

class ButtplugClientDeviceFeature {
  final int deviceIndex;
  final ClientDeviceFeature feature;
  final ButtplugClientCommunicator _communicator;
  bool _valid = true;

  ButtplugClientDeviceFeature(this._communicator, this.deviceIndex, this.feature);

  void markDisconnected() {
    _valid = false;
  }

  void _ensureValid() {
    if (!_valid) {
      throw ButtplugClientDeviceException('Device feature is disconnected');
    }
  }

  ClientDeviceFeatureOutputInfo _outputInfo(OutputType type) {
    final output = feature.output;
    if (output == null || !output.containsKey(type)) {
      throw ButtplugClientDeviceFeatureCapabilityException(
        '${feature.featureDescription} does not support $type output',
      );
    }
    final info = output[type];
    if (info == null || info.value == null || info.value!.length < 2) {
      throw ButtplugClientDeviceFeatureRangeException(
        '${feature.featureDescription} has no valid value range for $type output',
      );
    }
    return info;
  }

  List<int> _range(List<int>? range, String name) {
    if (range == null || range.length < 2 || range[0] > range[1]) {
      throw ButtplugClientDeviceFeatureRangeException(
        '${feature.featureDescription} has no valid $name range',
      );
    }
    return range;
  }

  int _outputValue(DeviceOutputCommand command, ClientDeviceFeatureOutputInfo info) {
    final range = _range(info.value, 'value');
    final value = command.value;
    final positional = command.outputType == OutputType.position ||
        command.outputType == OutputType.hwPositionWithDuration;
    if (value.steps != null) {
      final steps = value.steps!;
      if (steps == 0 && !positional) {
        return 0;
      }
      if (steps < range[0] || steps > range[1]) {
        throw ButtplugClientDeviceFeatureRangeException(
          '${feature.featureDescription} $steps is outside value range [${range[0]}, ${range[1]}]',
        );
      }
      return steps;
    }

    final percent = value.percent!;
    if (!percent.isFinite || percent < 0 || percent > 1) {
      throw ButtplugClientDeviceFeatureRangeException(
        '${feature.featureDescription} percentage must be finite and between 0 and 1',
      );
    }
    if (percent == 0 && !positional) {
      return 0;
    }
    if (!positional) {
      return (range[1] * percent).ceil().clamp(range[0], range[1]);
    }
    final span = range[1] - range[0];
    return (range[0] + span * percent).ceil().clamp(range[0], range[1]);
  }

  OutputCmd generateOutputCmd(DeviceOutputCommand command) {
    _ensureValid();
    final info = _outputInfo(command.outputType);
    final newCommand = ClientDeviceFeatureOutput()..value = _outputValue(command, info);

    if (command.outputType == OutputType.hwPositionWithDuration) {
      final duration = command.duration;
      if (duration == null) {
        throw ButtplugClientDeviceFeatureCapabilityException(
          'hwPositionWithDuration requires a duration',
        );
      }
      final durationRange = _range(info.duration, 'duration');
      if (duration < durationRange[0] || duration > durationRange[1] || duration < 0) {
        throw ButtplugClientDeviceFeatureRangeException(
          '${feature.featureDescription} duration $duration is outside range [${durationRange[0]}, ${durationRange[1]}]',
        );
      }
      newCommand.duration = duration;
    }

    final msg = OutputCmd()
      ..command[command.outputType] = newCommand
      ..deviceIndex = deviceIndex
      ..featureIndex = feature.featureIndex;
    return msg;
  }

  bool hasOutput(OutputType type) => _valid && (feature.output?.containsKey(type) ?? false);

  Future<void> runOutput(DeviceOutputCommand cmd) async {
    _ensureValid();
    await _communicator.sendMessageExpectOk(generateOutputCmd(cmd));
  }

  Future<Map<InputType, InputDataType>> readInput(InputType inputType) async {
    _ensureValid();
    final input = feature.input;
    if (input == null) {
      throw ButtplugClientDeviceFeatureCapabilityException(
        '${feature.featureDescription} does not have a readable input',
      );
    }
    final inputInfo = input[inputType];
    if (inputInfo == null) {
      throw ButtplugClientDeviceFeatureCapabilityException(
        '${feature.featureDescription} does not have input type $inputType',
      );
    }
    final supportsRead = inputInfo.command.any((command) => command.toLowerCase() == InputCommand.read.name.toLowerCase());
    if (!supportsRead) {
      throw ButtplugClientDeviceFeatureCapabilityException(
        '${feature.featureDescription} does not support Read for $inputType',
      );
    }

    final sensorReadMsg = InputCmd()
      ..deviceIndex = deviceIndex
      ..featureIndex = feature.featureIndex
      ..type = inputType
      ..command = InputCommand.read;
    final returnMsg = await _communicator.sendMessageExpectReply(sensorReadMsg);
    if (returnMsg.inputReading == null) {
      throw ButtplugClientDeviceFeatureCapabilityException(
        'Did not receive InputReading back from InputCmd transaction',
      );
    }
    return returnMsg.inputReading!.reading;
  }
}
