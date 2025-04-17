import 'dart:math';

import 'package:flutter/material.dart';

//! app theme colors

class MyColors {
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;
  static const Color primaryColor = Color(0xFF0EA4DC);
  static const Color secondaryColor = Color(0xFF17ADE0);
  static const Color ternaryColor = Color(0xFF43BEE6);
  static const Color appGreenColor = Color(0xFF279C85);
  static const Color blueIconsColor = Color.fromARGB(255, 10, 141, 188);
  static const Color lightGreyColor = Color(0xFFAFAFAF);
  static const Color lightColor = Color.fromARGB(119, 175, 175, 175);
  static const Color darkGreyColor = Color(0xFF818181);
  static const Color errorRed = Color.fromARGB(255, 187, 7, 7);
  static const Gradient themeGradient = LinearGradient( transform: GradientRotation(90 * pi / 180), colors: [Color.fromARGB(222, 67, 189, 230), primaryColor]);
}
