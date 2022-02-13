import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class Bluetooth {
  late BluetoothConnection connection;

  Bluetooth.connector() {
    BluetoothConnection.toAddress('00:21:13:01:05:E7')
        .then((value) => {connection = value});
  }

  sendValue(String value) {
    connection.output.add(ascii.encode(value));
  }

  close() async {
    await connection.close();
  }
}
