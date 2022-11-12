import 'package:buttplug/buttplug.dart';

class ButtplugClientDeviceException implements Exception {
  final String message;
  ButtplugClientDeviceException(this.message) : super();
}

// WHO EVEN NEEDS DISCRIMINATING UNIONS ANYWAYS.
class ButtplugDeviceCommand<T> {
  T? _commandAll;
  List<T>? _commandVec;
  Map<int, T>? _commandMap;
  ButtplugDeviceCommand._(this._commandAll, this._commandVec, this._commandMap);

  factory ButtplugDeviceCommand.setAll(T command) {
    return ButtplugDeviceCommand._(command, null, null);
  }

  factory ButtplugDeviceCommand.setVec(List<T> commandList) {
    return ButtplugDeviceCommand._(null, commandList, null);
  }

  factory ButtplugDeviceCommand.setMap(Map<int, T> commandMap) {
    return ButtplugDeviceCommand._(null, null, commandMap);
  }

  // Return the contents of the message as the map we need to fill out normal Buttplug command messages.
  Map<int, T> asMap(int featureCount) {
    if (_commandAll != null) {
      var map = <int, T>{};
      for (var i = 0; i < featureCount; ++i) {
        map[i] = _commandAll as T;
      }
      return map;
    }
    if (_commandVec != null) {
      var map = <int, T>{};
      for (var i = 0; i < _commandVec!.length; ++i) {
        map[i] = _commandVec![i];
      }
      return map;
    }
    return _commandMap!;
  }
}

class VibrateComponent {
  double speed;

  VibrateComponent(this.speed);
}

typedef VibrateCommand = ButtplugDeviceCommand<VibrateComponent>;

class ScalarComponent {
  double scalar;
  ActuatorType actuator;

  ScalarComponent(this.scalar, this.actuator);
}

typedef ScalarCommand = ButtplugDeviceCommand<ScalarComponent>;

class RotateComponent {
  double speed;
  bool clockwise;

  RotateComponent(this.speed, this.clockwise);
}

typedef RotateCommand = ButtplugDeviceCommand<RotateComponent>;

class LinearComponent {
  double position;
  int duration;

  LinearComponent(this.position, this.duration);
}

typedef LinearCommand = ButtplugDeviceCommand<LinearComponent>;

class ButtplugClientDevice {
  late final int index;
  late final String name;
  late final String? displayName;
  late final int? _messageTimingGap;
  late final ClientDeviceMessageAttributes messageAttributes;
  Function(ButtplugClientMessage msg) msgClosure;

  ButtplugClientDevice(DeviceInfo deviceInfo, this.msgClosure) {
    index = deviceInfo.deviceIndex;
    name = deviceInfo.deviceName;
    displayName = deviceInfo.deviceDisplayName;
    _messageTimingGap = deviceInfo.messageTimingGap;
    messageAttributes = deviceInfo.deviceMessages;
  }

  Future<void> _sendMessageExpectOk(ButtplugClientMessage message) async {
    ButtplugServerMessage okWrapper = await msgClosure(message);
    if (okWrapper.ok == null) {
      throw ButtplugClientException("Did not receive DeviceList message back from server on handshake.");
    }
  }

  bool connected() {
    return true;
  }

  Future<void> vibrate(VibrateCommand command) async {
    if (messageAttributes.scalarCmd == null ||
        !messageAttributes.scalarCmd!.any((element) => element.actuatorType == ActuatorType.Vibrate)) {
      throw ButtplugClientDeviceException("$name ($displayName) does not support vibration commands");
    }
    // Rebuild vibration command as scalar command
    var vibeCount =
        messageAttributes.scalarCmd!.where((element) => element.actuatorType == ActuatorType.Vibrate).length;
    var scalarMap = <int, ScalarComponent>{};
    command.asMap(vibeCount).forEach((key, value) {
      scalarMap[key] = ScalarComponent(value.speed, ActuatorType.Vibrate);
    });
    return await scalar(ScalarCommand.setMap(scalarMap));
  }

  Future<void> scalar(ScalarCommand command) async {
    if (messageAttributes.scalarCmd == null) {
      throw ButtplugClientDeviceException("$name ($displayName) does not support scalar commands");
    }
    var scalarMsg = ScalarCmd();
    scalarMsg.deviceIndex = index;
    var subcommandList = <ScalarSubcommand>[];
    command.asMap(messageAttributes.scalarCmd!.length).forEach((key, value) {
      subcommandList.add(ScalarSubcommand(key, value.scalar, value.actuator));
    });
    scalarMsg.scalars = subcommandList;
    return await _sendMessageExpectOk(scalarMsg);
  }

  Future<void> rotate(RotateCommand command) async {
    if (messageAttributes.rotateCmd == null) {
      throw ButtplugClientDeviceException("$name ($displayName) does not support rotate commands");
    }
    var rotateMsg = RotateCmd();
    rotateMsg.deviceIndex = index;
    var subcommandList = <RotateSubcommand>[];
    command.asMap(messageAttributes.rotateCmd!.length).forEach((key, value) {
      subcommandList.add(RotateSubcommand(key, value.speed, value.clockwise));
    });
    rotateMsg.rotations = subcommandList;
    return await _sendMessageExpectOk(rotateMsg);
  }

  Future<void> linear(LinearCommand command) async {
    if (messageAttributes.linearCmd == null) {
      throw ButtplugClientDeviceException("$name ($displayName) does not support linear commands");
    }
    var linearMsg = LinearCmd();
    linearMsg.deviceIndex = index;
    var subcommandList = <LinearSubcommand>[];
    command.asMap(messageAttributes.rotateCmd!.length).forEach((key, value) {
      subcommandList.add(LinearSubcommand(key, value.position, value.duration));
    });
    linearMsg.vectors = subcommandList;
    return await _sendMessageExpectOk(linearMsg);
  }
}
