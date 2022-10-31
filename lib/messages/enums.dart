// ignore_for_file: constant_identifier_names

// This should match what's in buttplug's rust server impl, but this is *not standardized*.
enum Endpoint {
  /// Expect to take commands, when multiple receive endpoints may be available
  Command,

  /// Firmware updates (Buttplug does not update firmware, but some firmware endpoints are used for
  /// mode setting)
  Firmware,

  /// Common receive endpoint name
  Rx,

  /// Receive endpoint for accelerometer data
  RxAccel,

  /// Receive endpoint for battery levels (usually expected to be BLE standard profile)
  RxBLEBattery,

  /// Receive endpoint for BLE model (usually expected to be BLE standard profile)
  RxBLEModel,

  /// Receive endpoint for pressure sensors
  RxPressure,

  /// Receive endpoint for touch sensors
  RxTouch,

  /// Common transmit endpoint name
  Tx,

  /// Transmit endpoint for hardware mode setting.
  TxMode,

  /// Transmit endpoint for shock setting (unused)
  TxShock,

  /// Transmit endpoint for vibration setting
  TxVibrate,

  /// Transmit endpoint for vendor (proprietary) control
  TxVendorControl,

  /// Transmit endpoint for whitelist updating
  Whitelist,

  /// Generic endpoint (available for user configurations)
  Generic0,

  /// Generic endpoint (available for user configurations)
  Generic1,

  /// Generic endpoint (available for user configurations)
  Generic2,

  /// Generic endpoint (available for user configurations)
  Generic3,

  /// Generic endpoint (available for user configurations)
  Generic4,

  /// Generic endpoint (available for user configurations)
  Generic5,

  /// Generic endpoint (available for user configurations)
  Generic6,

  /// Generic endpoint (available for user configurations)
  Generic7,

  /// Generic endpoint (available for user configurations)
  Generic8,

  /// Generic endpoint (available for user configurations)
  Generic9,

  /// Generic endpoint (available for user configurations)
  Generic10,

  /// Generic endpoint (available for user configurations)
  Generic11,

  /// Generic endpoint (available for user configurations)
  Generic12,

  /// Generic endpoint (available for user configurations)
  Generic13,

  /// Generic endpoint (available for user configurations)
  Generic14,

  /// Generic endpoint (available for user configurations)
  Generic15,

  /// Generic endpoint (available for user configurations)
  Generic16,

  /// Generic endpoint (available for user configurations)
  Generic17,

  /// Generic endpoint (available for user configurations)
  Generic18,

  /// Generic endpoint (available for user configurations)
  Generic19,

  /// Generic endpoint (available for user configurations)
  Generic20,

  /// Generic endpoint (available for user configurations)
  Generic21,

  /// Generic endpoint (available for user configurations)
  Generic22,

  /// Generic endpoint (available for user configurations)
  Generic23,

  /// Generic endpoint (available for user configurations)
  Generic24,

  /// Generic endpoint (available for user configurations)
  Generic25,

  /// Generic endpoint (available for user configurations)
  Generic26,

  /// Generic endpoint (available for user configurations)
  Generic27,

  /// Generic endpoint (available for user configurations)
  Generic28,

  /// Generic endpoint (available for user configurations)
  Generic29,

  /// Generic endpoint (available for user configurations)
  Generic30,

  /// Generic endpoint (available for user configurations)
  Generic31,
}

// This should match what's in buttplug's rust server impl, but this is *not standardized*.
// ignore: constant_identifier_names
enum ActuatorType { Vibrate, Rotate, Oscillate, Constrict, Inflate, Position }

// This should match what's in buttplug's rust server impl, but this is *not standardized*.
// ignore: constant_identifier_names
enum SensorType { Battery, RSSI, Button, Pressure, Temperature }
