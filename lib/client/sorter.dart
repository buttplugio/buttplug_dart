import 'dart:async';

import 'package:buttplug/messages/messages.dart';
import 'package:loggy/loggy.dart';

class MessageSorter {
  int messageCounter = 1;
  final Map<int, Completer<ButtplugServerMessage>> _waitingFutures = {};

  MessageSorter();

  void prepareMessage(ButtplugMessage outgoing) {
    outgoing.id = messageCounter;
    _waitingFutures[messageCounter] = Completer<ButtplugServerMessage>();
    messageCounter += 1;
  }

  Future<ButtplugServerMessage> waitForMessage(int id) async {
    final completer = _waitingFutures[id];
    if (completer == null) {
      logError("No message with $id currently being waited on");
      throw ButtplugMessageException("No message with $id currently being waited on");
    }
    try {
      return await completer.future;
    } finally {
      _waitingFutures.remove(id);
    }
  }

  void checkMessage(ButtplugServerMessage incoming) {
    final completer = _waitingFutures[incoming.id];
    if (completer == null) {
      logWarning("No message with ${incoming.id} currently being waited on");
      return;
    }
    if (!completer.isCompleted) {
      completer.complete(incoming);
    }
  }

  bool get hasPending => _waitingFutures.isNotEmpty;

  void failAll(Object error, [StackTrace? stackTrace]) {
    for (final completer in _waitingFutures.values) {
      if (!completer.isCompleted) {
        completer.completeError(error, stackTrace);
      }
    }
    _waitingFutures.clear();
  }
}
