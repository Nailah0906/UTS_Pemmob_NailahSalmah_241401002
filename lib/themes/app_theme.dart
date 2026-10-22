import 'package:flutter/material.dart';

class AppTheme {

  static const Color biruPastel = Color(0xFF7EA6D3); 
  static const Color cream = Color(0xFFFDFBF7);     
  static const Color abu = Color(0xFF4A5A6A);    
  static const Color white = Colors.white;

  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: cream,
      fontFamily: 'ComicRelief',
      primaryColor: biruPastel,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: abu,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: abu),
        bodyMedium: TextStyle(color: abu),
      ),
    );
  }
}