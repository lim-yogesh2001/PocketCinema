import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pocket_cinema_ticket/models/temp_ticket.dart';
import 'package:pocket_cinema_ticket/providers/login_provider.dart';
import 'package:provider/provider.dart';
import '../models/seat.dart';
import '../const/static.dart';
import 'package:http/http.dart' as http;

class SeatProvider with ChangeNotifier {
  List<Seat> _seats = [];
  TempTicket? tempTicket;

  get seats {
    return _seats;
  }

  Seat getSeatById(int seatId) {
    return _seats.firstWhere((element) => element.id == seatId);
  }

  Seat getSeatByIndex(int index){
    return _seats.elementAt(index);
  }

  Future<void> fetchSeats(String theaterID) async {
    final url = '$seatsUrl/$theaterID';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200 || response.statusCode >= 200){
        final extractedData = json.decode(response.body) as List<dynamic>;
        final list = extractedData.map((e) => Seat.fromJson(e));
        _seats = list.toList();
      }
      notifyListeners();
    }
    catch (e) {
      rethrow;
    }
  }

  Future<void> setReserveSeat(BuildContext context, int showId, int seatId) async {
    const url = reservedSeatUrl;
    // print(url);
    try{
      int? userId = Provider.of<LoginProvider>(context, listen: false).userId();
      Map<String, dynamic> reserveData = {
        "reserved": true,
        "user_id": userId.toInt(),
        "seat_id": seatId,
        "show_id": showId
      };
      final body = json.encode(reserveData);
      final response = await http.post(Uri.parse(url), body: body, headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        // 'authorization': 'Token $_token',
      });
      if (response.statusCode == 200 || response.statusCode >= 200){
        final extractedData = json.decode(response.body) as Map<String,dynamic>;
        tempTicket = TempTicket.fromJson(extractedData);
      }
     
    } catch (e){
      rethrow;
    }
  }

}