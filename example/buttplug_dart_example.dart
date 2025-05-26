import 'package:buttplug/buttplug.dart';
import 'package:loggy/loggy.dart';
import 'dart:math';

void main() async {
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(),
    logOptions: const LogOptions(
      LogLevel.all,
      stackTraceLevel: LogLevel.error,
    ),
  );
  logInfo("Starting client");
  var connector = ButtplugWebsocketClientConnector("ws://127.0.0.1:12345");
  ButtplugClient client = ButtplugClient("Dart Client Example");
  logInfo("Connecting to server");
  try {
    await client.connect(connector);
    logInfo("Server connected");
    await client.startScanning();
    logInfo("Holding for scan");
    await Future.delayed(Duration(seconds: 4));
    logInfo("Devices:");
    for (var device in client.devices.values) {
      logInfo("- ${device.name}");
      try {
        logInfo(device.features.where((x) => x.feature.featureType == "Vibrate").toList());
        logInfo(
            "Vibrating at ${device.features.where((x) => x.feature.featureType == "Vibrate").map((x) => x.feature.actuator!.stepCount).toList().reduce(max)}");
        await device.vibrate(device.features
            .where((x) => x.feature.featureType == "Vibrate")
            .map((x) => x.feature.actuator!.stepCount)
            .toList()
            .reduce(max));
        await Future.delayed(Duration(seconds: 3));
      } on ButtplugClientDeviceException catch (e) {
        logError(e.message);
      }
    }
    await client.disconnect();
    logInfo("Server disconnected");
  } on ButtplugClientException catch (e, s) {
    logError("Connection error: ${e.message}");
    logError(s);
    return;
  }
}
