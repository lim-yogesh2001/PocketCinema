import 'package:flutter/material.dart';
import '../const/static.dart';
import 'package:http/http.dart' as http;

class TicketProvider extends ChangeNotifier {
  Future<void> setBookTicket(
      {required code, required ticketId, required reserveSeatId}) async {
    const url = bookTicketUrl;
    try {
      final map = {
        'transection_code': code,
        'ticket_id': ticketId,
        'reserved_seat_id': reserveSeatId
      };
      await http.post(Uri.parse(url), body: map, headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });
    } catch (e) {
      rethrow;
    }
  }
}
