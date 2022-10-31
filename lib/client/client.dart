import 'package:buttplug/client/sorter.dart';
import 'package:buttplug/connectors/connector.dart';
import 'package:buttplug/messages/messages.dart';

class ButtplugClient {
  String _name;
  ButtplugClientConnector? _connector;
  MessageSorter _sorter = MessageSorter();

  ButtplugClient(this._name);

  Future<void> connect(ButtplugClientConnector connector) async {
    _connector = connector;
    _connector!.messageStream.listen((message) {
      if (message.id != 0) _sorter.checkMessage(message);
    });
    await _connector!.connect();
    await _runHandshake();
  }

  Future<void> disconnect() async {
    await _connector!.disconnect();
  }

  Future<void> _runHandshake() async {
    var requestServerInfo = RequestServerInfo();
    requestServerInfo.clientName = "Dart Client";
    _sorter.prepareMessage(requestServerInfo);
    _connector!.send(requestServerInfo.asClientMessage());
    ButtplugServerMessage serverInfo = await _sorter.waitForMessage(requestServerInfo.id);
    if (serverInfo.serverInfo == null) {}
    print("Server name: ${serverInfo.serverInfo!.serverName}");
  }

  Future<void> _parseMessage() async {}
}
