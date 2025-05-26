part of "../buttplug.dart";

// ignore_for_file: constant_identifier_names

// This should match what's in buttplug's rust server impl, but this is *not standardized*.
enum Endpoint {
  /// Expect to take commands, when multiple receive endpoints may be available
  @JsonValue("command")
  Command,

  /// Firmware updates (Buttplug does not update firmware, but some firmware endpoints are used for
  /// mode setting)
  @JsonValue("firmware")
  Firmware,

  /// Common receive endpoint name
  @JsonValue("rx")
  Rx,

  /// Receive endpoint for accelerometer data
  @JsonValue("rxaccel")
  RxAccel,

  /// Receive endpoint for battery levels (usually expected to be BLE standard profile)
  @JsonValue("rxblebattery")
  RxBLEBattery,

  /// Receive endpoint for BLE model (usually expected to be BLE standard profile)
  @JsonValue("rxblemodel")
  RxBLEModel,

  /// Receive endpoint for pressure sensors
  @JsonValue("rxpressure")
  RxPressure,

  /// Receive endpoint for touch sensors
  @JsonValue("rxtouch")
  RxTouch,

  /// Common transmit endpoint name
  @JsonValue("tx")
  Tx,

  /// Transmit endpoint for hardware mode setting.
  @JsonValue("txmode")
  TxMode,

  /// Transmit endpoint for vibration setting
  @JsonValue("txvibrate")
  TxVibrate,

  /// Transmit endpoint for vendor (proprietary) control
  @JsonValue("txvendorcontrol")
  TxVendorControl,

  /// Transmit endpoint for whitelist updating
  @JsonValue("txwhitelist")
  Whitelist,

  /// Generic endpoint (available for user configurations)
  @JsonValue("generic0")
  Generic0,

  /// Generic endpoint (available for user configurations)
  @JsonValue("generic1")
  Generic1,

  /// Generic endpoint (available for user configurations)
  @JsonValue("generic2")
  Generic2,

  /// Generic endpoint (available for user configurations)
  @JsonValue("generic3")
  Generic3,

  /// Generic endpoint (available for user configurations)
  @JsonValue("generic4")
  Generic4,

  /// Generic endpoint (available for user configurations)
  @JsonValue("generic5")
  Generic5,

  /// Generic endpoint (available for user configurations)
  @JsonValue("generic6")
  Generic6,

  /// Generic endpoint (available for user configurations)
  @JsonValue("generic7")
  Generic7,

  /// Generic endpoint (available for user configurations)
  @JsonValue("generic8")
  Generic8,

  /// Generic endpoint (available for user configurations)
  @JsonValue("generic9")
  Generic9,

  /// Generic endpoint (available for user configurations)
  @JsonValue("generic10")
  Generic10,

  /// Generic endpoint (available for user configurations)
  @JsonValue("generic11")
  Generic11,

  /// Generic endpoint (available for user configurations)
  @JsonValue("generic12")
  Generic12,

  /// Generic endpoint (available for user configurations)
  @JsonValue("generic13")
  Generic13,

  /// Generic endpoint (available for user configurations)
  @JsonValue("generic14")
  Generic14,

  /// Generic endpoint (available for user configurations)
  @JsonValue("generic15")
  Generic15,

  /// Generic endpoint (available for user configurations)
  @JsonValue("generic16")
  Generic16,

  /// Generic endpoint (available for user configurations)
  @JsonValue("generic17")
  Generic17,

  /// Generic endpoint (available for user configurations)
  @JsonValue("generic18")
  Generic18,

  /// Generic endpoint (available for user configurations)
  @JsonValue("generic19")
  Generic19,

  /// Generic endpoint (available for user configurations)
  @JsonValue("generic20")
  Generic20,

  /// Generic endpoint (available for user configurations)
  @JsonValue("generic21")
  Generic21,

  /// Generic endpoint (available for user configurations)
  @JsonValue("generic22")
  Generic22,

  /// Generic endpoint (available for user configurations)
  @JsonValue("generic23")
  Generic23,

  /// Generic endpoint (available for user configurations)
  @JsonValue("generic24")
  Generic24,

  /// Generic endpoint (available for user configurations)
  @JsonValue("generic25")
  Generic25,

  /// Generic endpoint (available for user configurations)
  @JsonValue("generic26")
  Generic26,

  /// Generic endpoint (available for user configurations)
  @JsonValue("generic27")
  Generic27,

  /// Generic endpoint (available for user configurations)
  @JsonValue("generic28")
  Generic28,

  /// Generic endpoint (available for user configurations)
  @JsonValue("generic29")
  Generic29,

  /// Generic endpoint (available for user configurations)
  @JsonValue("generic30")
  Generic30,

  /// Generic endpoint (available for user configurations)
  @JsonValue("generic31")
  Generic31,
}

// This should match what's in buttplug's rust server impl, but this is *not standardized*.
enum ActuatorType {
  Vibrate,
  Rotate,
  Oscillate,
  Constrict,
  Inflate,
  Position,
  PositionWithDuration,
  RotateWithDirection
}

// This should match what's in buttplug's rust server impl, but this is *not standardized*.
enum SensorType { Battery, RSSI, Button, Pressure, Temperature }
