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
    _wsChannel = WebSocketChannel.connect(Uri.parse(address));
    await _wsChannel?.ready;
    _wsChannel!.stream.listen(
      (element) {
        try {
          logInfo(element);
          List<dynamic> msgs = jsonDecode(element);
          for (var msg in msgs) {
            _serverMessageStream.add(ButtplugServerMessage.fromJson(msg));
          }
        } catch (e, s) {
          logError("Error adding message to stream: $e");
          logError(s);
          disconnect();
        }
      },
      onError: (error) {
        logError("WebSocket error: $error");
        disconnect();
      },
      onDone: () {
        logInfo("WebSocket connection closed");
        disconnect();
      },
      cancelOnError: true,
    );
  }

  @override
  Future<void> disconnect() async {
    if (_wsChannel == null) return;
    var ws = _wsChannel;
    _wsChannel = null;
    try {
      await ws?.sink.close();
    } catch (_) {}
    if (!_serverMessageStream.isClosed) {
      await _serverMessageStream.close();
    }
  }

  @override
  void send(List<ButtplugClientMessageUnion> messages) {
    if (_wsChannel == null) return;
    String msg = jsonEncode(messages);
    _wsChannel!.sink.add(msg);
  }

  @override
  Stream<ButtplugServerMessage> get messageStream => _serverMessageStream.stream;
}
