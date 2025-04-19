import 'package:flutter/material.dart';
import 'package:tip_calculator/core/constants/app_theme/app_colors.dart';
import 'package:tip_calculator/core/constants/screen_size/screen_size.dart';
import 'package:tip_calculator/features/home/view/screens/history_screen.dart';
import 'package:tip_calculator/features/home/view/widgets/positioned_time_tag_widget.dart';
import 'package:tip_calculator/features/home/view/widgets/tip_card_datas_widget.dart';

class HistoryCard extends StatelessWidget {
  final Map<String, dynamic> entry;final int index;
  final HistoryType sortedHistory;
  const HistoryCard({super.key, required this.entry, required this.index, required this.sortedHistory});

  @override
  Widget build(BuildContext context) {
       final date = entry['date'] as DateTime;
    return AnimatedContainer(
      duration: Duration(milliseconds: 500 + (index * 100)),
      curve: Curves.easeOut,
      transform: Matrix4.translationValues(
        0,
        sortedHistory.length > index ? 0 : 50,
        0,
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: ScreenSize.width,
          decoration: BoxDecoration(
            color: MyColors.ternaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              TipCardDatasWidget(entry: entry,),
              PositionedTimeTagWidget(date: date),
            ],
          ),
        ),
      ),
    );
  }
}
