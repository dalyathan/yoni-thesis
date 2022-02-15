import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:yoni_thesis/models/ItemData.dart';
import 'package:yoni_thesis/widgets/item_bar.dart';

import 'scanner.dart';

class ItemList extends StatefulWidget {
  final List<ItemData> items;
  const ItemList({Key? key, required this.items}) : super(key: key);

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  BluetoothConnection? connection;
  String message = "Connecting..";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      BluetoothConnection.toAddress('00:21:13:01:05:E7')
          .then<void>((value) => setState(() {
                connection = value;
              }))
          .catchError((onError) {
        setState(() {
          message = "Unable to Connect. Is Bluetooth On?";
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(54, 80, 111, 1),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 38.0),
            child: SizedBox(
              width: size.width,
              //height: size.height * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...widget.items.map((item) => InkWell(
                        onTap: connection != null
                            ? () => connection!.output.add(
                                ascii.encode(item.bluetoothValue.toString()))
                            : null,
                        child: ItemBar(data: item),
                      )),
                  connection == null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              message,
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.grey),
                            ),
                            ElevatedButton(
                                onPressed: message == "Connecting.."
                                    ? null
                                    : () {
                                        setState(() {
                                          message = "Connecting..";
                                        });
                                        BluetoothConnection.toAddress(
                                                '00:21:13:01:05:E7')
                                            .then<void>((value) => setState(() {
                                                  connection = value;
                                                }))
                                            .catchError((onError) {
                                          setState(() {
                                            message =
                                                "Unable to Connect. Is Bluetooth On?";
                                          });
                                        });
                                      },
                                child: const Text("Reconnect"))
                          ],
                        )
                      : ElevatedButton(
                          onPressed: () {
                            connection!.close(); //.then((value) =>
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text("Scan Again"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
