import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';

class Bluetooth {
  late BluetoothConnection? connection;

  Bluetooth.connector(BuildContext context) {
    BluetoothConnection.toAddress('00:21:13:01:05:E7')
        .then<void>((value) => {connection = value})
        .catchError((onError, stackTrace) async {
      print('---halogapppppp');
      await requestPermission(context);
    });
  }

  sendValue(String value) {
    connection!.output.add(ascii.encode(value));
  }

  close() async {
    await connection!.close();
  }

  requestPermission(BuildContext context) async {
    if (await Permission.location.isDenied) {
      if (await Permission.location.request().isDenied) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location request denied!'),
        ));
        Navigator.pop(context);
      }
    }
    if (await Permission.bluetooth.isDenied) {
      if (await Permission.bluetooth.request().isDenied) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Bluetooth request denied!'),
        ));
        Navigator.pop(context);
      }
    }
  }
}
