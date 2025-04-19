import 'package:flutter/material.dart';
import 'package:tip_calculator/core/constants/app_theme/app_colors.dart';
import 'package:tip_calculator/features/home/view/widgets/history_appbar_titles.dart';
import 'package:tip_calculator/features/home/view/widgets/history_body_coponents.dart';

typedef HistoryType = List<Map<String, dynamic>>;

class HistoryScreen extends StatefulWidget {
  final HistoryType history;

  const HistoryScreen({super.key, required this.history});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _sortBy = 'Newest';
  late HistoryType _sortedHistory;

  @override
  void initState() {
    super.initState();
    _sortedHistory = List.from(widget.history);
    _sortHistory();
  }

  void _sortHistory() {
    setState(() {
      if (_sortBy == 'Newest') {
        _sortedHistory.sort((a, b) => b['date'].compareTo(a['date']));
      } else if (_sortBy == 'Oldest') {
        _sortedHistory.sort((a, b) => a['date'].compareTo(b['date']));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.appBarThemeColor,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: MyColors.appBarThemeColor,
        scrolledUnderElevation: 0,
        title: HistoryAppbarTitles(),
        automaticallyImplyLeading: false,
        centerTitle: false,
        leadingWidth: 30,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: MyColors.blackColor,
            size: 20,
          ),
        ),
        actionsPadding: EdgeInsets.only(right: 10),
        actions: [
          PopupMenuButton<String>(
            color: MyColors.whiteColor,
            icon: Icon(
              Icons.tune_rounded,
              color: MyColors.blackColor,
              size: 24,
            ),
            padding: EdgeInsets.zero,
            onSelected: (String newValue) {
              setState(() {
                _sortBy = newValue;
                _sortHistory();
              });
            },
            itemBuilder:
                (BuildContext context) =>
                    ['Newest', 'Oldest']
                        .map(
                          (String value) => PopupMenuItem<String>(
                            value: value,
                            child: Text(
                              'Sort by: $value',
                              style: TextStyle(color: MyColors.blackColor),
                            ),
                          ),
                        )
                        .toList(),
          ),
        ],
      ),
      body: HistoryBodyCoponents(sortedHistory: _sortedHistory),
    );
  }
}
