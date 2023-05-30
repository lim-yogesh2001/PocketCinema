import 'package:flutter/material.dart';

SizedBox NotAvailable(double h, BuildContext context, String text) {
  return SizedBox(
    width: double.infinity,
    height: h * .7,
    child: Center(
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    ),
  );
}
