part of '../buttplug.dart';

class _ButtplugClientCommunicator {
  final StreamController<ButtplugClientEvent> eventStreamController = StreamController.broadcast();
  final ButtplugClientConnector _connector;
  final _MessageSorter _sorter = _MessageSorter();

  _ButtplugClientCommunicator(this._connector);

  Future<void> connect() async {
    _connector.messageStream.listen((message) {
      if (message.id != 0) {
        _sorter.checkMessage(message);
      }
    });
    await _connector.connect();
  }

  bool connected() {
    return true;
  }

  Future<void> disconnect() async {
    await _connector.disconnect();
  }

  Future<List<ButtplugServerMessage>> sendMessagesExpectReply(List<ButtplugClientMessage> messages) async {
    return await Future.wait(messages.map((x) {
      _sorter.prepareMessage(x);
      _connector.send([x.asClientMessageUnion()]);
      return _sorter.waitForMessage(x.id);
    }));
  }

  Future<ButtplugServerMessage> sendMessageExpectReply(ButtplugClientMessage message) async {
    return (await sendMessagesExpectReply([message]))[0];
  }

  Future<void> sendMessagesExpectOk(List<ButtplugClientMessage> messages) async {
    List<ButtplugServerMessage> responses = await sendMessagesExpectReply(messages);
    if (responses.where((x) => x.ok == null).isNotEmpty) {
      throw ButtplugClientException("Errors returned on messages: ${responses.where((x) => x.ok == null).toList()}");
    }
  }

  Future<void> sendMessageExpectOk(ButtplugClientMessage messages) async {
    await sendMessagesExpectOk([messages]);
  }

  Stream<ButtplugClientEvent> get eventStream => eventStreamController.stream;
}
