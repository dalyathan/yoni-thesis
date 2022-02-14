import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../models/ItemData.dart';
import 'item_list.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    bool qrRecognized = false;
    if (result != null && qrRecognized == false) {
      List<ItemData>? values = tryParse(result!.code!, context);
      if (values != null) {
        controller?.pauseCamera(); //.then((value) {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          qrRecognized = false;
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ItemList(
                      items: values,
                    )),
          ).then((value) {
            qrRecognized = false;
            controller?.resumeCamera();
          });
        });
        // });
        qrRecognized = true;
      }
    }
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 20, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (result == null)
                    const Text(
                      'Scan a code',
                      style: TextStyle(fontSize: 10),
                    )
                  else if (result != null && qrRecognized == false)
                    const Text(
                      'Unknown format',
                      style: TextStyle(fontSize: 10),
                    )
                  else if (result != null && qrRecognized == true)
                    const Text(
                      'Loading..',
                      style: TextStyle(fontSize: 10),
                    )
                  else
                    const Text(
                      'Scan a code',
                      style: TextStyle(fontSize: 10),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  List<ItemData>? tryParse(String scannedValue, BuildContext context) {
    late List<List<dynamic>> value;
    try {
      value = List<List<dynamic>>.from(json.decode(scannedValue));
    } catch (error) {
      print(error);
      return null;
    }
    for (var possibleItem in value) {
      if (possibleItem.length != 6 ||
          double.tryParse(possibleItem[3]) == null ||
          Uri.tryParse(possibleItem[1]) == null ||
          int.tryParse(possibleItem[4]) == null ||
          int.tryParse(possibleItem[5]) == null) {
        print("error at " + possibleItem.toString());
        return null;
      }
    }
    return value
        .map((item) => ItemData(item[0], item[1], item[2],
            double.parse(item[3]), int.parse(item[4]), int.parse(item[5])))
        .toList();
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 500.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
