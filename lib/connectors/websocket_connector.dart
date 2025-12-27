import 'dart:async';
import 'dart:convert';

import 'package:buttplug/buttplug.dart';
import 'package:loggy/loggy.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ButtplugWebsocketClientConnector implements ButtplugClientConnector {
  String address;
  WebSocketChannel? _wsChannel;
  final StreamController<ButtplugServerMessage> _serverMessageStream = StreamController.broadcast();

  ButtplugWebsocketClientConnector(this.address);

  @override
  Future<void> connect() async {
    _wsChannel = WebSocketChannel.connect(Uri.parse('ws://127.0.0.1:12345'));
    await _wsChannel?.ready;
    _wsChannel!.stream.forEach((element) async {
      try {
        logInfo(element);
        List<dynamic> msgs = jsonDecode(element);
        for (var msg in msgs) {
          _serverMessageStream.add(ButtplugServerMessage.fromJson(msg));
        }
      } catch (e, s) {
        logError("Error adding message to stream: $e");
        logError(s);
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
  void send(List<ButtplugClientMessageUnion> messages) {
    String msg = jsonEncode(messages);
    _wsChannel!.sink.add(msg);
  }

  @override
  Stream<ButtplugServerMessage> get messageStream => _serverMessageStream.stream;
}
