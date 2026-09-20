import 'dart:async';
import 'dart:convert';

import 'package:buttplug/buttplug.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ButtplugWebsocketClientConnector implements ButtplugClientConnector {
  String address;
  WebSocketChannel? _wsChannel;
  StreamSubscription? _wsSubscription;
  final StreamController<ButtplugServerMessage> _serverMessageStream = StreamController.broadcast();
  bool _started = false;

  ButtplugWebsocketClientConnector(this.address);

  @override
  Future<void> connect() async {
    if (_started) throw StateError('Websocket connector has already been used');
    _started = true;
    WebSocketChannel? channel;
    try {
      channel = WebSocketChannel.connect(Uri.parse(address));
      _wsChannel = channel;
      _wsSubscription = channel.stream.listen(
        (element) {
          try {
            final msgs = jsonDecode(element);
            for (final msg in msgs) {
              _serverMessageStream.add(ButtplugServerMessage.fromJson(msg));
            }
          } catch (_) {
            unawaited(disconnect());
          }
        },
        onError: (Object error, StackTrace stackTrace) {
          unawaited(disconnect());
        },
        onDone: () {
          unawaited(disconnect());
        },
      );
      await channel.ready;
      if (!identical(_wsChannel, channel)) {
        throw ButtplugClientException('Connection closed during connect');
      }
    } catch (_) {
      await disconnect();
      rethrow;
    }
  }

  @override
  Future<void> disconnect() async {
    final channel = _wsChannel;
    final subscription = _wsSubscription;
    _wsChannel = null;
    _wsSubscription = null;
    // Notify request waiters before waiting for the WebSocket close handshake.
    unawaited(_serverMessageStream.close());
    try {
      await subscription?.cancel();
    } finally {
      if (channel != null) {
        try {
          await channel.sink.close();
        } catch (_) {}
      }
    }
  }

  @override
  void send(List<ButtplugClientMessageUnion> messages) {
    final channel = _wsChannel;
    if (channel == null) {
      throw StateError('Cannot send while websocket is disconnected');
    }
    channel.sink.add(jsonEncode(messages));
  }

  @override
  Stream<ButtplugServerMessage> get messageStream => _serverMessageStream.stream;
}
