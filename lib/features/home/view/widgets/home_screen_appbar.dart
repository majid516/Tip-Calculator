import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:tip_calculator/core/constants/app_theme/app_colors.dart';
import 'package:tip_calculator/core/constants/spaces/space.dart';
import 'package:tip_calculator/features/home/view/screens/history_screen.dart';
import 'package:tip_calculator/features/home/view/screens/home_screen.dart';

class HomeScreenAppbar extends StatelessWidget {
  const HomeScreenAppbar({
    super.key,
    required List<Map<String, dynamic>> history,
  }) : _history = history;

  final List<Map<String, dynamic>> _history;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: MyColors.appBarThemeColor,
      elevation: 0,
      toolbarHeight: 80,
      scrolledUnderElevation: 0,
      leadingWidth: 15,
      leading: Space.hSpace15,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Ready to Tip?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: MyColors.blackColor,
            ),
          ),
          Text(
            'Tip Calculator',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: MyColors.blackColor,
            ),
          ),
        ],
      ),
      centerTitle: false,
      actions: [
        Showcase(
          tooltipPadding:EdgeInsets.all(10) ,
          key: historyIconKey,
          description: 'Go to Recap',
          targetShapeBorder: const CircleBorder(), 
          targetPadding: const EdgeInsets.all(8),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (ctx) => HistoryScreen(history: _history),
                ),
              );
            },
            icon: const Icon(
              Icons.view_agenda_outlined,
              color: MyColors.blackColor,
            ),
          ),
        ),
      ],
    );
  }
}
