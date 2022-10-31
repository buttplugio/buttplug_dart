import 'dart:async';
import 'dart:convert';

import 'package:buttplug/connectors/connector.dart';
import 'package:buttplug/messages/messages.dart';
import 'package:loggy/loggy.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ButtplugWebsocketClientConnector implements ButtplugClientConnector {
  String address;
  WebSocketChannel? _wsChannel;
  final StreamController<ButtplugServerMessage> _serverMessageStream = StreamController();

  ButtplugWebsocketClientConnector(this.address);

  @override
  Future<void> connect() async {
    _wsChannel = WebSocketChannel.connect(
      Uri.parse('ws://127.0.0.1:12345'),
    );
    _wsChannel!.stream.forEach((element) async {
      try {
        List<dynamic> msgs = jsonDecode(element);
        for (var msg in msgs) {
          logInfo(msg);
          _serverMessageStream.add(ButtplugServerMessage.fromJson(msg));
        }
      } catch (e) {
        logError(element);
        logError("Error adding message to stream: $e");
        await disconnect();
      }
    });
  }

  @override
  Future<void> disconnect() async {
    _wsChannel!.sink.close();
    _wsChannel = null;
  }

  @override
  void send(ButtplugClientMessageUnion message) {
    String msg = jsonEncode([message]);
    _wsChannel!.sink.add(msg);
  }

  @override
  Stream<ButtplugServerMessage> get messageStream => _serverMessageStream.stream;
}
