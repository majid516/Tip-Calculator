import 'package:flutter/material.dart';
import 'package:tip_calculator/core/constants/app_theme/app_colors.dart';

class HistoryAppbarTitles extends StatelessWidget {
  const HistoryAppbarTitles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recaps',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: MyColors.blackColor,
          ),
        ),
        SizedBox(
          width: 250,
          child: Text(
            'All your past calculations at a glance',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: MyColors.blackColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
