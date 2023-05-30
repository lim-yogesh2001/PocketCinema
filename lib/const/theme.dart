import 'package:flutter/material.dart';

ThemeData customTheme() {
    return ThemeData(
        scaffoldBackgroundColor: Colors.black87,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        primarySwatch: Colors.deepOrange,
        primaryColor: Colors.orange,
        textTheme: const TextTheme(
          titleMedium:  TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              color: Colors.white),
          titleSmall:  TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
              color: Colors.white70),
          labelSmall:  TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
            color: Colors.white70
          )
        ),
      );
  }