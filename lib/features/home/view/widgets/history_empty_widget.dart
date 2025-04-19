import 'package:flutter/material.dart';
import 'package:tip_calculator/core/constants/app_theme/app_colors.dart';
import 'package:tip_calculator/core/constants/spaces/space.dart';

class HistoryEmptyWidget extends StatelessWidget {
  const HistoryEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         
          Text(
            'No History Yet!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: MyColors.darkGreyColor,
            ),
          ),
        Space.hSpace10,
          Text(
            'Start calculating tips to see them here.',
            style: TextStyle(fontSize: 16, color: MyColors.darkGreyColor),
            textAlign: TextAlign.center,
          ),
          Space.hSpace15,
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
              backgroundColor: WidgetStateColor.resolveWith((_)=>MyColors.ternaryColor)
            ),
            child: Text(
              'Back to Calculator',
              style: TextStyle(color: MyColors.blackColor),
            ),
          ),
        ],
      ),
    );
  }
}
