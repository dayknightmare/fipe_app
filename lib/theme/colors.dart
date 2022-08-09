import 'package:flutter/material.dart';

const MaterialColor fipeColorPalette = MaterialColor(
  0xFF00607a,
  <int, Color>{
    50: Color(0xFFC3D4D9),
    100: Color(0xFF7DBED0),
    200: Color(0xFF3CA9C7),
    300: Color(0xFF009CC7),
    400: Color(0xFF2B7B91),
    500: Color(0xFF00607a),
    600: Color(0xFF005066),
    700: Color(0xFF004052),
    800: Color(0xFF00303d),
    900: Color(0xFF002029),
  },
);

Color luminanceColor(Color c) {
  return c.computeLuminance() > 0.4 ? Colors.black : Colors.white;
}
