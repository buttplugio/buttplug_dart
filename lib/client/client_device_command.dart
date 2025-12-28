import 'package:buttplug/messages/messages.dart';

class PercentOrSteps {
  final int? steps;
  final double? percent;

  PercentOrSteps._(this.steps, this.percent);

  static PercentOrSteps fromSteps(int i) {
    return PercentOrSteps._(i, null);
  }

  static PercentOrSteps fromPercent(double d) {
    return PercentOrSteps._(null, d);
  }
}

class DeviceOutputCommand {
  final OutputType outputType;
  final PercentOrSteps value;
  final int? duration;

  DeviceOutputCommand(this.outputType, this.value, this.duration);
}

class DeviceOutputValueConstructor {
  final OutputType _outputType;

  DeviceOutputValueConstructor(this._outputType);

  DeviceOutputCommand steps(int steps) {
    return DeviceOutputCommand(_outputType, PercentOrSteps.fromSteps(steps), null);
  }

  DeviceOutputCommand percent(double percent) {
    return DeviceOutputCommand(_outputType, PercentOrSteps.fromPercent(percent), null);
  }
}

class DeviceOutputPositionWithDurationConstructor {
  DeviceOutputPositionWithDurationConstructor();

  DeviceOutputCommand steps(int steps, int duration) {
    return DeviceOutputCommand(OutputType.positionWithDuration, PercentOrSteps.fromSteps(steps), duration);
  }

  DeviceOutputCommand percent(double percent, int duration) {
    return DeviceOutputCommand(OutputType.positionWithDuration, PercentOrSteps.fromPercent(percent), duration);
  }
}

class DeviceOutput {
  static DeviceOutputValueConstructor get vibrate {
    return DeviceOutputValueConstructor(OutputType.vibrate);
  }

  static DeviceOutputValueConstructor get rotate {
    return DeviceOutputValueConstructor(OutputType.rotate);
  }

  static DeviceOutputValueConstructor get oscillate {
    return DeviceOutputValueConstructor(OutputType.oscillate);
  }

  static DeviceOutputValueConstructor get constrict {
    return DeviceOutputValueConstructor(OutputType.constrict);
  }

  static DeviceOutputValueConstructor get inflate {
    return DeviceOutputValueConstructor(OutputType.inflate);
  }

  static DeviceOutputValueConstructor get temperature {
    return DeviceOutputValueConstructor(OutputType.temperature);
  }

  static DeviceOutputValueConstructor get led {
    return DeviceOutputValueConstructor(OutputType.led);
  }

  static DeviceOutputValueConstructor get spray {
    return DeviceOutputValueConstructor(OutputType.spray);
  }

  static DeviceOutputValueConstructor get position {
    return DeviceOutputValueConstructor(OutputType.position);
  }

  static DeviceOutputPositionWithDurationConstructor get positionWithDuration {
    return DeviceOutputPositionWithDurationConstructor();
  }
}
