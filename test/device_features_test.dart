import 'dart:async';

import 'package:buttplug/buttplug.dart';
import 'package:test/test.dart';

void main() {
  final communicators = <ButtplugClientCommunicator>[];

  setUp(() {
    addTearDown(() async {
      for (final communicator in communicators) {
        if (communicator.connected()) {
          await communicator.disconnect();
        }
      }
      communicators.clear();
    });
  });

  Future<ButtplugClientCommunicator> connectedCommunicator(FakeConnector connector) async {
    final communicator = ButtplugClientCommunicator(connector);
    communicators.add(communicator);
    await communicator.connect();
    return communicator;
  }

  test('positional percentages map inclusive advertised range', () async {
    final connector = FakeConnector();
    final communicator = await connectedCommunicator(connector);
    final feature = makeFeature(
      communicator,
      output: {OutputType.hwPositionWithDuration: outputInfo([10, 100], [10, 1000])},
    );

    expect(feature.generateOutputCmd(DeviceOutput.positionWithDuration.percent(0, 10)).command[OutputType.hwPositionWithDuration]!.value, 10);
    expect(feature.generateOutputCmd(DeviceOutput.positionWithDuration.percent(.5, 10)).command[OutputType.hwPositionWithDuration]!.value, 55);
    expect(feature.generateOutputCmd(DeviceOutput.positionWithDuration.percent(1, 10)).command[OutputType.hwPositionWithDuration]!.value, 100);
  });

  test('stop-capable output permits zero outside its nonzero advertised range', () async {
    final connector = FakeConnector();
    final communicator = await connectedCommunicator(connector);
    final feature = makeFeature(
      communicator,
      output: {OutputType.vibrate: outputInfo([10, 20])},
    );

    expect(feature.generateOutputCmd(DeviceOutput.vibrate.steps(0)).command[OutputType.vibrate]!.value, 0);
    expect(feature.generateOutputCmd(DeviceOutput.vibrate.percent(0)).command[OutputType.vibrate]!.value, 0);
  });

  test('signed steps remain supported and percentages use positive maximum scaling', () async {
    final connector = FakeConnector();
    final communicator = await connectedCommunicator(connector);
    final feature = makeFeature(
      communicator,
      output: {OutputType.rotate: outputInfo([-20, 20])},
    );

    expect(feature.generateOutputCmd(DeviceOutput.rotate.steps(-20)).command[OutputType.rotate]!.value, -20);
    expect(feature.generateOutputCmd(DeviceOutput.rotate.percent(.5)).command[OutputType.rotate]!.value, 10);
  });

  test('percentage rejects NaN, infinity, negative, and values above one', () async {
    final connector = FakeConnector();
    final communicator = await connectedCommunicator(connector);
    final feature = makeFeature(
      communicator,
      output: {OutputType.vibrate: outputInfo([0, 20])},
    );

    for (final percent in [double.nan, double.infinity, -0.01, 1.01]) {
      expect(
        () => feature.generateOutputCmd(DeviceOutput.vibrate.percent(percent)),
        throwsA(isA<ButtplugClientDeviceFeatureRangeException>()),
      );
    }
  });

  test('input-only feature rejects output steps and percentages without sending', () async {
    final connector = FakeConnector();
    final communicator = await connectedCommunicator(connector);
    final input = ClientDeviceFeatureInputInfo()..command = ['Read'];
    final feature = makeFeature(communicator, input: {InputType.battery: input});

    expect(
      () => feature.generateOutputCmd(DeviceOutput.vibrate.steps(1)),
      throwsA(isA<ButtplugClientDeviceFeatureCapabilityException>()),
    );
    expect(
      () => feature.generateOutputCmd(DeviceOutput.vibrate.percent(.5)),
      throwsA(isA<ButtplugClientDeviceFeatureCapabilityException>()),
    );
    expect(connector.sentCount, 0);
  });

  test('steps and duration are inclusive and reject invalid values', () async {
    final connector = FakeConnector();
    final communicator = await connectedCommunicator(connector);
    final feature = makeFeature(
      communicator,
      output: {OutputType.hwPositionWithDuration: outputInfo([0, 100], [10, 1000])},
    );

    expect(feature.generateOutputCmd(DeviceOutput.positionWithDuration.steps(100, 1000)), isA<OutputCmd>());
    expect(
      () => feature.generateOutputCmd(DeviceOutput.positionWithDuration.steps(101, 1000)),
      throwsA(isA<ButtplugClientDeviceFeatureRangeException>()),
    );
    expect(
      () => feature.generateOutputCmd(DeviceOutput.positionWithDuration.steps(50, 9)),
      throwsA(isA<ButtplugClientDeviceFeatureRangeException>()),
    );
  });

  test('input read requires advertised Read command', () async {
    final connector = FakeConnector();
    final communicator = await connectedCommunicator(connector);
    final input = ClientDeviceFeatureInputInfo()..command = ['Subscribe'];
    final feature = makeFeature(communicator, input: {InputType.battery: input});

    expect(
      () => feature.readInput(InputType.battery),
      throwsA(isA<ButtplugClientDeviceFeatureCapabilityException>()),
    );
    expect(connector.sentCount, 0);
  });

  test('markDisconnected invalidates retained device and feature handles', () async {
    final connector = FakeConnector();
    final communicator = await connectedCommunicator(connector);
    final info = DeviceInfo()
      ..deviceIndex = 3
      ..deviceName = 'test device'
      ..deviceFeatures = {
        0: (ClientDeviceFeature()
          ..featureIndex = 0
          ..output = {OutputType.vibrate: outputInfo([0, 20])})
      };
    final device = ButtplugClientDevice(info, communicator);
    final retainedFeature = device.features[0]!;
    expect(device.connected, isTrue);

    device.markDisconnected();

    expect(device.connected, isFalse);
    await expectLater(device.runOutput(DeviceOutput.vibrate.steps(1)), throwsA(isA<ButtplugClientDeviceException>()));
    await expectLater(device.battery(), throwsA(isA<ButtplugClientDeviceException>()));
    await expectLater(retainedFeature.runOutput(DeviceOutput.vibrate.steps(1)), throwsA(isA<ButtplugClientDeviceException>()));
    await expectLater(retainedFeature.readInput(InputType.battery), throwsA(isA<ButtplugClientDeviceException>()));
    expect(connector.sentCount, 0);
  });

  test('communicator disconnect updates connected state', () async {
    final connector = FakeConnector();
    final communicator = await connectedCommunicator(connector);
    expect(communicator.connected(), isTrue);
    await communicator.disconnect();
    expect(communicator.connected(), isFalse);
  });

  test('battery selects one readable feature and sends one request', () async {
    final connector = FakeConnector();
    final communicator = await connectedCommunicator(connector);
    final battery = ClientDeviceFeatureInputInfo()..command = ['Read'];
    final info = DeviceInfo()
      ..deviceIndex = 3
      ..deviceName = 'battery device'
      ..deviceFeatures = {
        0: (ClientDeviceFeature()..featureIndex = 0..input = {InputType.battery: battery}),
        1: (ClientDeviceFeature()..featureIndex = 1..input = {InputType.battery: battery}),
      };
    final device = ButtplugClientDevice(info, communicator);
    final sendNotification = connector.nextSend;
    final future = device.battery();
    await sendNotification.future;
    expect(connector.sentCount, 1);
    connector.replyInput(42);
    expect(await future, 42);
  });
}

ButtplugClientDeviceFeature makeFeature(
  ButtplugClientCommunicator communicator, {
  Map<OutputType, ClientDeviceFeatureOutputInfo>? output,
  Map<InputType, ClientDeviceFeatureInputInfo>? input,
}) {
  final descriptor = ClientDeviceFeature()
    ..featureIndex = 1
    ..featureDescription = 'test feature'
    ..output = output
    ..input = input;
  return ButtplugClientDeviceFeature(communicator, 4, descriptor);
}

ClientDeviceFeatureOutputInfo outputInfo(List<int> value, [List<int>? duration]) =>
    ClientDeviceFeatureOutputInfo()
      ..value = value
      ..duration = duration;

class FakeConnector implements ButtplugClientConnector {
  final StreamController<ButtplugServerMessage> _messages = StreamController.broadcast();
  int sentCount = 0;
  int _lastId = 0;
  bool connected = false;
  Completer<void> _nextSend = Completer<void>();

  Completer<void> get nextSend => _nextSend;

  @override
  Future<void> connect() async => connected = true;

  @override
  Future<void> disconnect() async {
    connected = false;
    await _messages.close();
  }

  @override
  void send(List<ButtplugClientMessageUnion> messages) {
    sentCount += messages.length;
    if (messages.isNotEmpty) {
      _lastId = messages.first.id;
    }
    if (!_nextSend.isCompleted) {
      _nextSend.complete();
    }
    _nextSend = Completer<void>();
  }

  @override
  Stream<ButtplugServerMessage> get messageStream => _messages.stream;

  void replyInput(int value) {
    final reading = InputReading()
      ..id = _lastId
      ..featureIndex = 0
      ..reading = {InputType.battery: (InputDataType()..value = value)};
    _messages.add(ButtplugServerMessage()..inputReading = reading);
  }
}
