import 'package:flutter/material.dart';
import 'package:tip_calculator/core/constants/app_theme/app_colors.dart';
import 'package:tip_calculator/features/home/view/screens/history_screen.dart';
import 'package:tip_calculator/features/home/view/widgets/history_card.dart';
import 'package:tip_calculator/features/home/view/widgets/history_empty_widget.dart';

class HistoryBodyCoponents extends StatelessWidget {
  const HistoryBodyCoponents({
    super.key,
    required HistoryType sortedHistory,
  }) : _sortedHistory = sortedHistory;

  final HistoryType _sortedHistory;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: MyColors.whiteColor,
            child:
                _sortedHistory.isEmpty
                    ? HistoryEmptyWidget()
                    : ListView.builder(
                      padding: EdgeInsets.all(4.0),
                      itemCount: _sortedHistory.length,
                      itemBuilder: (context, index) {
                        final entry = _sortedHistory[index];
                        return HistoryCard(
                          entry: entry,
                          index: index,
                          sortedHistory: _sortedHistory,
                        );
                      },
                    ),
          ),
        ),
      ],
    );
  }
}
