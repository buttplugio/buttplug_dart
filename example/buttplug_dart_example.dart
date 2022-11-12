import 'package:buttplug/buttplug.dart';
import 'package:loggy/loggy.dart';

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
  var client = ButtplugClient("Dart Client Example");
  logInfo("Connecting to server");
  await client.connect(connector);
  logInfo("Server connected");
  await client.startScanning();
  logInfo("Holding for scan");
  await Future.delayed(Duration(seconds: 10));
  logInfo("Devices:");
  for (var device in client.devices.values) {
    logInfo("- ${device.name}");
  }
  await client.disconnect();
  logInfo("Server disconnected");
}
