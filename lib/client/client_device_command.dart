part of '../buttplug.dart';

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
  final PercentOrSteps? value;
  final PercentOrSteps? position;
  final int? duration;

  DeviceOutputCommand._(this.outputType, this.value, this.position, this.duration);
}

class DeviceOutputValueConstructor {
  final OutputType _outputType;

  DeviceOutputValueConstructor._(this._outputType);

  DeviceOutputCommand steps(int steps) {
    return DeviceOutputCommand._(_outputType, PercentOrSteps.fromSteps(steps), null, null);
  }

  DeviceOutputCommand percent(double percent) {
    return DeviceOutputCommand._(_outputType, PercentOrSteps.fromPercent(percent), null, null);
  }
}

class DeviceOutputPositionConstructor {
  DeviceOutputPositionConstructor._();

  DeviceOutputCommand steps(int steps) {
    return DeviceOutputCommand._(OutputType.position, null, PercentOrSteps.fromSteps(steps), null);
  }

  DeviceOutputCommand percent(double percent) {
    return DeviceOutputCommand._(OutputType.position, null, PercentOrSteps.fromPercent(percent), null);
  }
}

class DeviceOutputPositionWithDurationConstructor {
  DeviceOutputPositionWithDurationConstructor._();

  DeviceOutputCommand steps(int steps, int duration) {
    return DeviceOutputCommand._(OutputType.positionWithDuration, null, PercentOrSteps.fromSteps(steps), duration);
  }

  DeviceOutputCommand percent(double percent, int duration) {
    return DeviceOutputCommand._(OutputType.positionWithDuration, null, PercentOrSteps.fromPercent(percent), duration);
  }
}

class DeviceOutput {
  static DeviceOutputValueConstructor get vibrate {
    return DeviceOutputValueConstructor._(OutputType.vibrate);
  }

  static DeviceOutputValueConstructor get rotate {
    return DeviceOutputValueConstructor._(OutputType.rotate);
  }

  static DeviceOutputValueConstructor get oscillate {
    return DeviceOutputValueConstructor._(OutputType.oscillate);
  }

  static DeviceOutputValueConstructor get constrict {
    return DeviceOutputValueConstructor._(OutputType.constrict);
  }

  static DeviceOutputValueConstructor get inflate {
    return DeviceOutputValueConstructor._(OutputType.inflate);
  }

  static DeviceOutputValueConstructor get temperature {
    return DeviceOutputValueConstructor._(OutputType.temperature);
  }

  static DeviceOutputValueConstructor get led {
    return DeviceOutputValueConstructor._(OutputType.led);
  }

  static DeviceOutputValueConstructor get spray {
    return DeviceOutputValueConstructor._(OutputType.spray);
  }

  static DeviceOutputPositionConstructor get position {
    return DeviceOutputPositionConstructor._();
  }

  static DeviceOutputPositionWithDurationConstructor get positionWithDuration {
    return DeviceOutputPositionWithDurationConstructor._();
  }
}
