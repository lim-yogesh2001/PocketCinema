import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pocket_cinema_ticket/providers/login_provider.dart';
import 'package:provider/provider.dart';
import '../models/profile.dart';
import '../const/static.dart';
import 'package:http/http.dart' as http;

class ProfileProvider extends ChangeNotifier {
  Profile profileDetails = Profile(
      username: null,
      email: null,
      phone: null,
      fullName: null,
      dateJoined: null);

  Future<void> fetchProfile(BuildContext context, String userId) async {
    final url = "$profileUrl/$userId";
    try {
      final token = Provider.of<LoginProvider>(context, listen: false).token();
      final response = await http.get(Uri.parse(url), headers: {
        'authorization': 'Token $token',
      });
      if (response.statusCode == 200 || response.statusCode >= 200) {
        final extractedData = json.decode(response.body);
        profileDetails = Profile.fromJson(extractedData);
        // print(profileDetails.email);
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editProile(BuildContext context,
      {required username,
      required email,
      required phone,
      required fullName}) async {
    final userId = Provider.of<LoginProvider>(context, listen: false).userId();
    final url = "$profileUrl/$userId/";
    try {
      final token = Provider.of<LoginProvider>(context, listen: false).token();
      await http.put(Uri.parse(url),
          body: json.encode({
            'username': username,
            'phone': phone,
            'email': email,
            'full_name': fullName,
          }),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'authorization': 'Token $token',
          });
    } catch (e) {
      rethrow;
    }
  }
}
