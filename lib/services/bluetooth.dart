import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';

class Bluetooth {
  static connect() async {
    FlutterBlue flutterBlue = FlutterBlue.instance;
    await flutterBlue
        .startScan(timeout: const Duration(seconds: 15))
        .catchError((error) async {
      print('hayloga');
      if (await Permission.bluetooth.isDenied) {
        PermissionStatus status = await Permission.bluetooth.request();
        if (status.isDenied) {
          return;
        }
      }
    });
// Listen to scan results
    var subscription = flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        //00:21:13:01:05:E7
        print('${r.device.id.id} found! rssi: ${r.rssi}');
      }
    });

// Stop scanning
    // flutterBlue.stopScan();
  }
}
