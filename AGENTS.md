# AGENTS.md

This file provides guidance to agent harnesses when working with code in this repository.

## Project Overview

Buttplug Dart is a pure Dart implementation of the Buttplug Message Specification v4 client library. It enables applications to communicate with intimate devices through a standard message-based protocol.

**Important**: This library is NOT designed for web/WASM compilation due to int/float comparison assumptions that fail in JavaScript environments.

## Common Commands

```bash
# Run tests
dart test

# Run a single test file
dart test test/buttplug_test.dart

# Regenerate JSON serialization code after modifying messages.dart
dart run build_runner build

# Watch mode for code generation during development
dart run build_runner watch

# Run linter
dart analyze

# Get dependencies
dart pub get
```

## Architecture

The library follows a layered, event-driven architecture:

```
ButtplugClient (main API)
    ↓
ButtplugClientCommunicator (message routing, request/response correlation)
    ↓
ButtplugClientConnector (transport interface)
    ↓
ButtplugWebsocketClientConnector (WebSocket to local server at ws://127.0.0.1:12345)
```

### Key Components

- **lib/buttplug.dart**: Main entry point, exports all public APIs
- **lib/client/client.dart**: `ButtplugClient` - manages device lifecycle and events
- **lib/client/client_communicator.dart**: Handles async request-response correlation using `MessageSorter`
- **lib/client/client_device.dart**: `ButtplugClientDevice` - represents a connected device with features
- **lib/client/client_device_feature.dart**: Individual device capabilities (vibration, rotation, etc.)
- **lib/client/client_device_command.dart**: Fluent API for building device commands (`DeviceOutput.vibrate.percent(0.5)`)
- **lib/connectors/**: Transport layer implementations
- **lib/messages/messages.dart**: All Buttplug v4 message definitions with JSON serialization

### Message System

Messages use `json_annotation` with generated serialization code in `messages.g.dart`. After modifying `messages.dart`, regenerate with `dart run build_runner build`.

Key message types:
- Client → Server: `RequestServerInfo`, `RequestDeviceList`, `StartScanning`, `StopScanning`, `OutputCmd`, `InputCmd`, `StopCmd`
- Server → Client: `Ok`, `Error`, `ServerInfo`, `DeviceList`, `ScanningFinished`, `InputReading`

### Event System

Client fires events through `eventStream: Stream<ButtplugClientEvent>`:
- `DeviceAddedEvent`
- `DeviceRemovedEvent`
- `DeviceListReceivedEvent`

### Exception Types

- `ButtplugClientException`: Connection/client errors
- `ButtplugClientDeviceException`: Device operation errors
- `ButtplugMessageException`: Message parsing errors
