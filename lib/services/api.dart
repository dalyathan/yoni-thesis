import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import '../models/SignUp.dart';

class Api {
  static const String url = 'https://odd-buttons-knock-196-188-51-249.loca.lt';

  static Future<Map> login(String username, String password) async {
    var requestUrl = '$url/login';
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

  static Future<Map> uploadProfilePicture(
      FilePickerResult? result, String token) async {
    var uri = Uri.parse('$url/upload_img');

    var request = http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = http.MultipartFile(
        'file', result!.files[0].readStream!, result.files[0].size,
        filename: result.files[0].path);
    // add file to multipart
    request.files.add(multipartFile);
    request.headers.addAll({
      'Authorization': 'Bearer $token',
    });

    try {
      var response = await request.send();
      print(response.statusCode);

      return {
        "status": response.statusCode,
        "message": "",
      };
    } on SocketException catch (e) {
      print(e);
      return {
        "status": -1,
        "message": "Please connect to the internet or try again"
      };
    }
  }

  static String makeAbsolute(String end) => "$url$end";

  static Future<int> logout(String token) async {
    var requestUrl = '$url/logout';
    try {
      var response = await http.get(
        Uri.parse(requestUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      return response.statusCode;
    } on SocketException catch (e) {
      print(e);
      return -1;
    }
  }

  static Future<Map> profile(String token) async {
    var requestUrl = '$url/profile';
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
    var requestUrl = '$url/signup';
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
