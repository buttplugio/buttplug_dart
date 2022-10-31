import 'package:buttplug/messages/messages.dart';

abstract class ButtplugClientConnector {
  Future<void> connect();
  Future<void> disconnect();
  void send(ButtplugClientMessage message);
  Stream<ButtplugServerMessage> get messageStream;
}
