import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yoni_thesis/models/ItemData.dart';

class ItemBar extends StatelessWidget {
  final ItemData data;
  const ItemBar({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size.width * 0.05),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: size.width * 0.2,
            height: size.width * 0.2,
            child: CachedNetworkImage(imageUrl: data.imageUrl),
          ),
          Column(
            children: [
              Text(data.name),
              Text('${data.amount} in stock'),
              Text('${data.price} ETB')
            ],
          )
        ],
      ),
    );
  }
}
