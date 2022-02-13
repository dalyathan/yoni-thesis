import 'package:flutter/material.dart';
import 'package:yoni_thesis/models/ItemData.dart';
import 'package:yoni_thesis/widgets/item_bar.dart';

import '../services/bluetooth.dart';

class ItemList extends StatefulWidget {
  const ItemList({Key? key}) : super(key: key);

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
      bluetooth = Bluetooth.connector();
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
                  InkWell(
                    onTap: () => bluetooth.sendValue("1"),
                    //behavior: HitTestBehavior.translucent,
                    child: ItemBar(
                        data: ItemData(
                            'Apple', 'Kg', 22.34, '${assetUrl}apple.jpg')),
                  ),
                  InkWell(
                      onTap: () => bluetooth.sendValue("2"),
                      child: ItemBar(
                          data: ItemData('Avocado', 'Kg', 17.34,
                              '${assetUrl}avocado.jpg'))),
                  InkWell(
                      onTap: () => bluetooth.sendValue("3"),
                      child: ItemBar(
                          data: ItemData(
                              'Banana', 'Kg', 52.34, '${assetUrl}banana.jpg'))),
                  ElevatedButton(
                      onPressed: () => bluetooth.close(),
                      child: const Text("Close connection"))
                  // ItemBar(
                  //     data: ItemData(
                  //         'Cabbage', 'Kg', 42.34, '${assetUrl}cabbage.jpg')),
                  // ItemBar(
                  //     data: ItemData(
                  //         'Carrot', 'Kg', 262.34, '${assetUrl}carrot.jpg')),
                  // ItemBar(
                  //     data: ItemData(
                  //         'lettuce', 'Kg', 28.34, '${assetUrl}lettuce.jpg')),
                  // ItemBar(
                  //     data:
                  //         ItemData('Mango', 'Kg', 62.34, '${assetUrl}mango.jpg')),
                  // ItemBar(
                  //     data: ItemData(
                  //         'Onions', 'Kg', 52.34, '${assetUrl}onions.jpg')),
                  // ItemBar(
                  //     data: ItemData(
                  //         'Orange', 'Kg', 62.34, '${assetUrl}orange.jpg')),
                  // ItemBar(
                  //     data: ItemData(
                  //         'Papaya', 'Kg', 562.34, '${assetUrl}papaya.jpg')),
                  // ItemBar(
                  //     data: ItemData(
                  //         'Spinach', 'Kg', 62.34, '${assetUrl}spinach.jpg')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
