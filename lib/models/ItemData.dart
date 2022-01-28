// ignore: file_names
class ItemData {
  final String name;
  final String imageUrl;
  final String metric;
  final double price;
  int amount = 0;

  ItemData(this.name, this.metric, this.price, this.imageUrl);
}