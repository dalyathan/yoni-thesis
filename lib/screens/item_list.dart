import 'package:flutter/material.dart';
import 'package:yoni_thesis/models/ItemData.dart';
import 'package:yoni_thesis/widgets/item_bar.dart';

import '../services/bluetooth.dart';

class ItemList extends StatefulWidget {
  final List<ItemData> items;
  const ItemList({Key? key, required this.items}) : super(key: key);

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  late Bluetooth bluetooth;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      bluetooth = Bluetooth.connector(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    String assetUrl = 'assets/images/';
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 38.0),
            child: SizedBox(
              width: size.width,
              height: size.height * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ...widget.items.map((item) => InkWell(
                        onTap: () =>
                            bluetooth.sendValue(item.bluetoothValue.toString()),
                        child: ItemBar(
                            data: ItemData(item.name, item.imageUrl,
                                item.metric, item.price, item.bluetoothValue)),
                      )),
                  ElevatedButton(
                      onPressed: () => bluetooth.close(),
                      child: const Text("Close connection"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
