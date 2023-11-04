import 'dart:async';

import 'package:buttplug/messages/messages.dart';
import 'package:loggy/loggy.dart';

class MessageCompletionFuture {
  Future<ButtplugServerMessage> completionFuture;
  Sink<ButtplugServerMessage> completionSink;
  MessageCompletionFuture(this.completionSink, this.completionFuture);
}

class MessageSorter {
  int messageCounter = 1;
  Map<int, MessageCompletionFuture> waitingFutures = {};

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
    waitingFutures[messageCounter] = MessageCompletionFuture(responseStream.sink, Future(() async {
      return await responseCompleter.future;
    }));
    messageCounter += 1;
  }

  Future<ButtplugServerMessage> waitForMessage(int id) async {
    if (!waitingFutures.containsKey(id)) {
      logError("No message with $id currently being waited on");
      throw ButtplugMessageException("No message with $id currently being waited on");
    }
    return await waitingFutures[id]!.completionFuture;
  }

  void checkMessage(ButtplugServerMessage incoming) {
    if (!waitingFutures.containsKey(incoming.id)) {
      logWarning("No message with ${incoming.id} currently being waited on");
      return;
    }
    waitingFutures[incoming.id]!.completionSink.add(incoming);
  }
}
