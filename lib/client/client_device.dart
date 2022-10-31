import 'package:buttplug/buttplug.dart';

class ButtplugClientDevice {
  late final int _deviceIndex;
  late final String deviceName;
  late final String? deviceDisplayName;
  late final int? _messageTimingGap;
  late final ClientDeviceMessageAttributes messageAttributes;

  ButtplugClientDevice(DeviceInfo deviceInfo) {
    _deviceIndex = deviceInfo.deviceIndex;
    deviceName = deviceInfo.deviceName;
    deviceDisplayName = deviceInfo.deviceDisplayName;
    _messageTimingGap = deviceInfo.messageTimingGap;
    messageAttributes = deviceInfo.deviceMessages;
  }
}
