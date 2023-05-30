// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:pocket_cinema_ticket/components/app_bar.dart';
import 'package:pocket_cinema_ticket/providers/book_ticket.dart';
import 'package:pocket_cinema_ticket/screens/home.dart';
import '../providers/seat_provider.dart';
import 'package:provider/provider.dart';
import '../models/show.dart';
import '../components/custom_text.dart';
import '../components/alert_box.dart';

class PaymentScreen extends StatelessWidget {
  final Show show;
  final int seatId;
  const PaymentScreen({required this.show, required this.seatId, super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final seatProvider = Provider.of<SeatProvider>(context, listen: false);
    final tempTicket = seatProvider.tempTicket;
    final seatInfo = seatProvider.getSeatById(seatId);

    final config = PaymentConfig(
      amount: tempTicket!.price,
      productIdentity: tempTicket.id.toString(),
      productName: show.movie.movieName,
      productUrl: 'https://www.khalti.com/#/bazaar',
      additionalData: {
        'vendor': 'Pocket Cinema'
      }
    );
    return Scaffold(
        appBar: customAppBar(context, "Payment Details"),
        body: Center(
          child: SizedBox(
            width: w * .75,
            height: h * .55,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  gradient: const LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      colors: [Colors.deepPurple, Colors.purple])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Your Payment",
                    style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  ),
                  const SizedBox(height: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(text: 'Movie Name:  ${show.movie.movieName}'),
                      CustomText(text: 'Show Time:  ${show.showTime}'),
                      CustomText(
                          text:
                              'Seat:  Row-${seatInfo.row} Number-${seatInfo.number}'),
                      CustomText(text: 'Theater:  ${show.theater.theaterName}'),
                      CustomText(text: 'Price:  ${tempTicket.price}'),
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  KhaltiButton.wallet(
                      config: config,
                      onSuccess: (success) async {
                        CustomAlertBox().customLoadingDialog(context);
                        await Provider.of<TicketProvider>(context,
                                listen: false)
                            .setBookTicket(
                                code: success.idx,
                                ticketId: tempTicket.id,
                                reserveSeatId: seatInfo.id);
                        Navigator.pop(context);
                        await CustomAlertBox().normalAlertBox(
                            context, "Ticket Booked Successfully!");
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                          (route) => false,
                        );
                      },
                      onFailure: (failure){
                        CustomAlertBox().normalAlertBox(context, failure.message);
                      })
                ],
              ),
            ),
          ),
        ));
  }
}
