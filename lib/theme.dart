import 'package:flutter/material.dart';

class AppTheme {
  static final light = ThemeData(
    useMaterial3: true,
    fontFamily: 'OpenSans',
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF333333),
      onPrimary: Color(0xFFF3F3F3),
      primaryContainer: Color(0xFFF3F3F3),
      onPrimaryContainer: Colors.blue,
      secondary: Color(0xFF3B9DFF),
      onSecondary: Color(0xFFF3F3F3),
      onSecondaryContainer: Color(0xFF333333),
      error: Colors.redAccent,
      onError: Colors.red,
      errorContainer: Colors.redAccent,
      onErrorContainer: Color(0xFFF9DEDC),
      outline: Color(0xFFF3F3F3),
      background: Color(0xFFF3F3F3),
      onBackground: Color(0xFF333333),
      surface: Color(0xFFF3F3F3),
    ),
    textTheme: ThemeData.light().textTheme.copyWith(
          bodyMedium: const TextStyle(
            fontSize: 16.0,
          ),
        ),
  );

  static final dark = ThemeData(
    useMaterial3: true,
    fontFamily: 'Open Sans',
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF333333),
      onPrimary: Colors.blue,
      primaryContainer: Colors.blue,
      onPrimaryContainer: Color(0xFF333333),
      secondary: Color(0xFF3B9DFF),
      onSecondary: Color(0xFFF3F3F3),
      secondaryContainer: Color(0xFFF0A000),
      onSecondaryContainer: Color(0xFF333333),
      error: Colors.redAccent,
      onError: Colors.red,
      errorContainer: Colors.redAccent,
      onErrorContainer: Color(0xFFF9DEDC),
      outline: Color(0xFF938F99),
      background: Color(0xFF333333),
      onBackground: Color(0xFFF3F3F3),
      surface: Color(0xFF333333),
      onSurface: Color(0xFFF3F3F3),
      surfaceVariant: Color(0xFF49454F),
      onSurfaceVariant: Color(0xFFCAC4D0),
    ),
    textTheme: ThemeData.light().textTheme.copyWith(
          bodyMedium: const TextStyle(
            fontSize: 16.0,
          ),
        ),
  );
}
