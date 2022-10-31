import 'package:buttplug/messages/messages.dart';

abstract class ButtplugClientConnector {
  Future<void> connect();
  Future<void> disconnect();
  void send(ButtplugClientMessageUnion message);
  Stream<ButtplugServerMessage> get messageStream;
}
