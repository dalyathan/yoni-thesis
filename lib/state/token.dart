import 'package:flutter/material.dart';

class Token extends ChangeNotifier {
  String token = '';
  setToken(String token) {
    this.token = token;
    notifyListeners();
  }
}
