import 'package:buttplug/buttplug.dart';
import 'package:buttplug/messages/messages.dart';
import 'package:loggy/loggy.dart';

void main() async {
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(),
    logOptions: const LogOptions(LogLevel.all, stackTraceLevel: LogLevel.error),
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
        logInfo(device.features.values.where((x) => x.hasOutput(OutputType.vibrate)).toList());
        logInfo(
          "Vibrating at ${device.features.values.where((x) => x.hasOutput(OutputType.vibrate)).map((x) => x.feature.output![OutputType.vibrate]!.value![1])}",
        );
        await device.runOutput(DeviceOutput.vibrate.percent(1.0));
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
