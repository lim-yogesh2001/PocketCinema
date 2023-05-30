// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pocket_cinema_ticket/components/alert_box.dart';
import 'package:pocket_cinema_ticket/providers/movie_provider.dart';
import 'package:pocket_cinema_ticket/screens/login.dart';
import 'package:provider/provider.dart';
import '../const/static.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class LoginProvider extends ChangeNotifier {
  String? _token;
  int? _userId;

  int userId() {
    return _userId ?? 0;
  }

  String token() {
    return _token.toString();
  }

  Future<void> login(String username, String password) async {
    const url = "$accountApi/login/";
    try {
      final response = await http.post(Uri.parse(url), body: {
        "username": username,
        "password": password,
      });
      if (response.statusCode == 200 || response.statusCode >= 200) {
        final extractedData = json.decode(response.body);
        final credentials = User.fromJson(extractedData);
        _userId = credentials.user.id;
        _token = credentials.token;
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout(BuildContext context) async {
    const url = "$accountApi/logout/";
    try {
      CustomAlertBox().customLoadingDialog(context);
      await http.post(Uri.parse(url), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': 'Token $_token',
      });
      Navigator.pop(context);
      Provider.of<MovieProvider>(context, listen: false).resetMovies();
      _token = null;
      _userId = null;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
          (route) => false);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changePassword(BuildContext context, String oldPw, String newPw) async {
    const url = "$accountApi/change-password/";
    try {
      final response = await http.put(Uri.parse(url), body: json.encode({
        'old_password': oldPw,
        'new_password': newPw,
      }), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': 'Token $_token',
      });
      if (response.statusCode == 200 || response.statusCode >= 200){
        final extractedData = json.decode(response.body) as Map<String, dynamic>;
        final data = extractedData;
      }
    } catch (e) {
      rethrow;
    }
  }
}
