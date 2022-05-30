import 'package:flutter/material.dart';
import 'package:yoni_thesis/models/account.dart';

class Profile extends ChangeNotifier {
  late Account account;

  setAccount(Account account) {
    this.account = account;
  }
}
