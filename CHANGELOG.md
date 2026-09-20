# 1.0.1 (2026-09-20)

## Bugfixes

- Honour the configured WebSocket address and propagate server disconnects to the client.
- Reject pending requests on disconnect or transport failure, clean up completed requests, and safely handle duplicate or unknown replies.
- Guard concurrent connection attempts and clean up failed or cancelled handshakes.
- Report actual device connection state and reject commands from removed devices and retained feature handles.
- Remove the unsupported `Command` field from v4 `StopCmd` serialization and deserialization.
- Validate output capabilities, value and duration ranges, and finite percentages. Map positional percentages across the advertised range while preserving zero-stop semantics for other outputs.
- Require advertised `Read` support for input reads and issue only one request when reading battery level.
- Preserve device identity between initial device events and the client device map, and emit the initial device-list event.

## Maintenance

- Update v4 test fixtures, restore serialization coverage, and replace timing-based event waits with deterministic synchronization.
- Add regression tests for request lifecycle, real WebSocket failures, device validation, and message serialization.
- Add GitHub Actions checks for Dart analysis and tests.
- Clarify that web/WASM compilation is unsupported.
- Verify against current resolved dependencies while retaining existing compatible dependency constraints.

# 1.0.0 (2025-12-31)

## Features

- Update to Spec v4

# 0.0.4 (2023-11-04)

## Bugfixes

- Check if futures are completed before trying to resolve them again
- Check if we're waiting on a specific future before trying to resolve it

# 0.0.3 (2023-07-09)

## Bugfixes

- Fix de/serialization of Raw Commands in device enumeration messages.

# 0.0.2 (2023-01-16)

## Features

- Enough of an implementation to work with the device panel in Intiface Central.
- Mostly releasing this so we no longer have relative dependency links in Intiface Central.

# 0.0.1 (2022-10-30)

## Features

- First slapped-together-in-an-afternoon version
- Can connect to server, that's about it
- Releasing this version mostly so I can capture the package name on pub.dev.
