import 'package:flutter/material.dart';
import 'package:tip_calculator/core/constants/screen_size/screen_size.dart';
import 'package:tip_calculator/features/home/view/screens/home_screen.dart';

void main() {
  runApp(TipCalculatorApp());
}

class TipCalculatorApp extends StatelessWidget {
  const TipCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
   
    ScreenSize.initialize(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TipCalculatorScreen(),
    );
  }
}

