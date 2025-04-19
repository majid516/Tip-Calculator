import 'package:flutter/material.dart';
import 'package:tip_calculator/core/constants/app_theme/app_colors.dart';

void showCustomSnackBar(BuildContext context, String message, bool isError ) {
  final snackBar = SnackBar(
    content: Row(
      children: [
        Icon(
          isError ? Icons.error_outline : Icons.check_circle_outline,
          color: MyColors.blackColor,
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            message,
            style: TextStyle(fontSize: 16, color: MyColors.blackColor),
          ),
        ),
      ],
    ),
    backgroundColor: isError ? MyColors.primaryColor : MyColors.successGreen,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    duration: Duration(seconds: 3),
    action: SnackBarAction(
      label: 'Dismiss',
      textColor: MyColors.blackColor,
      onPressed: () {
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
