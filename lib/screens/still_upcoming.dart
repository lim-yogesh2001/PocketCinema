import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pocket_cinema_ticket/components/app_bar.dart';

class UpcomingScreen extends StatelessWidget {
  final DateTime time;
  const UpcomingScreen({required this.time, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, "Upcoming Movie"),
      body: Center(
        child: Text(
          "Please wait until ${DateFormat.yMMMEd().format(time)} for the upcoming movie",
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
