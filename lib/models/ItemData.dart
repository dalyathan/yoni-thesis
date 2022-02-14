// ignore: file_names
class ItemData {
  final String name;
  final String imageUrl;
  final String metric;
  final double price;
  final int bluetoothValue;
  int amount = 0;

  ItemData(
      this.name, this.imageUrl, this.metric, this.price, this.bluetoothValue);
}
