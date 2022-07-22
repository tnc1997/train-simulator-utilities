import 'package:flutter/material.dart';

class AppColors {
  static const blue = MaterialColor(
    _bluePrimaryValue,
    <int, Color>{
      50: Color(0xFFE3F6FC),
      100: Color(0xFFBAE8F8),
      200: Color(0xFF8CD9F4),
      300: Color(0xFF5DCAF0),
      400: Color(0xFF3BBEEC),
      500: Color(_bluePrimaryValue),
      600: Color(0xFF15ACE6),
      700: Color(0xFF11A3E3),
      800: Color(0xFF0E9ADF),
      900: Color(0xFF088BD9),
    },
  );
  static const _bluePrimaryValue = 0xFF18B3E9;

  static const blueAccent = MaterialColor(
    _blueAccentValue,
    <int, Color>{
      100: Color(0xFFFFFFFF),
      200: Color(_blueAccentValue),
      400: Color(0xFF9CD6FF),
      700: Color(0xFF83CCFF),
    },
  );
  static const _blueAccentValue = 0xFFCFEBFF;
}
