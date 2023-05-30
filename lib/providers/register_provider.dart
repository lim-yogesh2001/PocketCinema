import 'package:flutter/material.dart';
import '../const/static.dart';
import 'package:http/http.dart' as http;

class RegisterProvider with ChangeNotifier {
  Future<void> registerUser(
      {required String username,
      required String password,
      required String email,
      required String fullName,
      required String phone}) async {
    const url = "$accountApi/register/";
    try {
      await http.post(Uri.parse(url), body: {
        "username": username,
        "password": password,
        "email": email,
        "full_name": fullName,
        "phone": phone
      });
    } catch (e) {
      rethrow;
    }
  }
}
