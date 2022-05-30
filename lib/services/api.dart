import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../models/SignUp.dart';

class Api {
  static const String url = 'https://tidy-hands-create-196-188-160-24.loca.lt/';

  static Future<Map> login(String username, String password) async {
    var requestUrl = '${url}login';
    try {
      http.Response response = await http.post(Uri.parse(requestUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
              <String, String>{"username": username, "password": password}));
      return {"status": response.statusCode, "message": response.body};
    } on SocketException catch (e) {
      print(e);
      return {
        "status": -1,
        "message": "Please connect to the internet or try again"
      };
    }
  }

  static Future<Map> profile(String token) async {
    var requestUrl = '${url}profile';
    try {
      http.Response response = await http.get(
        Uri.parse(requestUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      return {"status": response.statusCode, "message": response.body};
    } on SocketException catch (e) {
      print(e);
      return {
        "status": -1,
        "message": "Please connect to the internet or try again"
      };
    }
  }

  static Future<Map> signup(SignUp json) async {
    var requestUrl = '${url}signup';
    try {
      http.Response response = await http.post(Uri.parse(requestUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(json.toJson()));
      return {"status": response.statusCode, "message": response.body};
    } on SocketException catch (e) {
      print(e);
      return {
        "status": -1,
        "message": "Please connect to the internet or try again"
      };
    }
  }

  static bool buy() {
    return false;
  }
}
