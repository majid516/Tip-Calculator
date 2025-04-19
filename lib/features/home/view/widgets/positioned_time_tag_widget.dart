import 'package:flutter/material.dart';
import 'package:tip_calculator/core/constants/app_theme/app_colors.dart';

class PositionedTimeTagWidget extends StatelessWidget {
  const PositionedTimeTagWidget({
    super.key,
    required this.date,
  });

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final difference = now.difference(date);
    final seconds = difference.inSeconds;
    final minutes = difference.inMinutes;
    final hours = difference.inHours;

    String timeText;
    if (seconds < 60) {
      timeText = '$seconds sec ago';
    } else if (minutes < 60) {
      timeText = '$minutes min ago';
    } else {
      timeText = '$hours hr ago';
    }

    return Positioned(
      top: 12,
      right: 12,
      child: Text(
        timeText,
        style: TextStyle(
          fontSize: 14,
          color: MyColors.darkGreyColor,
        ),
      ),
    );
  }
}