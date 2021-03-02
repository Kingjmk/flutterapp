import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
    primarySwatch: Colors.blue,
    accentColor: Colors.blueAccent,
    snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.grey,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16),
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
        )
    ),
);
