import 'package:flutter/material.dart';
import 'package:tip_calculator/core/constants/app_theme/app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColors.primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        
      ),
    ),
    
  );
}
