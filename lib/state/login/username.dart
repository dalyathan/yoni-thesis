import 'package:flutter/material.dart';

class Username extends ChangeNotifier {
  String username = '';

  setUsername(String username) {
    this.username = username;
    notifyListeners();
  }
}
