import 'dart:async';
import 'dart:convert';

import 'package:buttplug/messages/messages.dart';
import 'package:loggy/loggy.dart';

class _MessageCompletionFuture {
  Future<ButtplugServerMessage> completionFuture;
  Sink<ButtplugServerMessage> completionSink;
  _MessageCompletionFuture(this.completionSink, this.completionFuture);
}

class MessageSorter {
  int messageCounter = 1;
  final Map<int, _MessageCompletionFuture> _waitingFutures = {};

  MessageSorter();

  void prepareMessage(ButtplugMessage outgoing) {
    outgoing.id = messageCounter;
    StreamController<ButtplugServerMessage> responseStream = StreamController();
    var responseCompleter = Completer<ButtplugServerMessage>();
    responseStream.stream.listen((ButtplugServerMessage msg) {
      if (!responseCompleter.isCompleted) {
        responseCompleter.complete(msg);
      }
    });
    _waitingFutures[messageCounter] = _MessageCompletionFuture(
      responseStream.sink,
      Future(() async {
        return await responseCompleter.future;
      }),
    );
    messageCounter += 1;
  }

  Future<ButtplugServerMessage> waitForMessage(int id) async {
    if (!_waitingFutures.containsKey(id)) {
      logError("No message with $id currently being waited on");
      throw ButtplugMessageException("No message with $id currently being waited on");
    }
    return await _waitingFutures[id]!.completionFuture;
  }

  void checkMessage(ButtplugServerMessage incoming) {
    if (!_waitingFutures.containsKey(incoming.id)) {
      logWarning("No message with ${incoming.id} currently being waited on");
      return;
    }
    _waitingFutures[incoming.id]!.completionSink.add(incoming);
  }
}
