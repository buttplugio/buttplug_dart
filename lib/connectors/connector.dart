import 'package:buttplug/buttplug.dart';

abstract class ButtplugClientConnector {
  Future<void> connect();
  Future<void> disconnect();
  void send(List<ButtplugClientMessageUnion> message);
  Stream<ButtplugServerMessage> get messageStream;
}
