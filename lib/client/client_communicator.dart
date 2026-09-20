import 'dart:async';

import 'package:buttplug/buttplug.dart';

class ButtplugClientCommunicator {
  final StreamController<ButtplugClientEvent> eventStreamController = StreamController.broadcast();
  final ButtplugClientConnector _connector;
  final MessageSorter _sorter = MessageSorter();
  StreamSubscription<ButtplugServerMessage>? _messageSubscription;
  bool _connected = false;
  bool _transportClosed = false;

  ButtplugClientCommunicator(this._connector);

  Future<void> connect() async {
    _transportClosed = false;
    _messageSubscription ??= _connector.messageStream.listen(
      (message) {
        if (message.id != 0) {
          _sorter.checkMessage(message);
        }
      },
      onError: (Object error, StackTrace stackTrace) {
        _markDisconnected(error, stackTrace);
      },
      onDone: () {
        _markDisconnected(ButtplugClientException("Connection closed"));
      },
    );
    try {
      await _connector.connect();
      if (_transportClosed) {
        throw ButtplugClientException("Connection closed during connect");
      }
      _connected = true;
    } catch (error, stackTrace) {
      _markDisconnected(error, stackTrace);
      rethrow;
    }
  }

  bool connected() => _connected;

  Future<void> disconnect() async {
    _markDisconnected(ButtplugClientException("Disconnected"));
    final subscription = _messageSubscription;
    _messageSubscription = null;
    try {
      await _connector.disconnect();
    } finally {
      await subscription?.cancel();
    }
  }

  Future<List<ButtplugServerMessage>> sendMessagesExpectReply(List<ButtplugClientMessage> messages) async {
    if (!_connected) {
      throw ButtplugClientException("Cannot send message while disconnected");
    }
    final replies = <Future<ButtplugServerMessage>>[];
    for (final message in messages) {
      _sorter.prepareMessage(message);
      replies.add(_sorter.waitForMessage(message.id));
    }
    final result = Future.wait(replies);
    try {
      for (final message in messages) {
        _connector.send([message.asClientMessageUnion()]);
      }
    } catch (error, stackTrace) {
      _markDisconnected(error, stackTrace);
    }
    return result;
  }

  Future<ButtplugServerMessage> sendMessageExpectReply(ButtplugClientMessage message) async {
    return (await sendMessagesExpectReply([message]))[0];
  }

  Future<void> sendMessagesExpectOk(List<ButtplugClientMessage> messages) async {
    final responses = await sendMessagesExpectReply(messages);
    if (responses.where((x) => x.ok == null).isNotEmpty) {
      throw ButtplugClientException("Errors returned on messages: ${responses.where((x) => x.ok == null).toList()}");
    }
  }

  Future<void> sendMessageExpectOk(ButtplugClientMessage message) async {
    await sendMessagesExpectOk([message]);
  }

  Stream<ButtplugClientEvent> get eventStream => eventStreamController.stream;

  void _markDisconnected(Object error, [StackTrace? stackTrace]) {
    _connected = false;
    _transportClosed = true;
    _sorter.failAll(error, stackTrace);
  }

}
