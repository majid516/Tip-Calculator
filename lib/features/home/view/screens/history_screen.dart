import 'package:flutter/material.dart';
import 'package:tip_calculator/core/constants/app_theme/app_theme.dart';
import 'package:tip_calculator/core/constants/screen_size/screen_size.dart';
import 'package:tip_calculator/features/home/view/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:tip_calculator/core/constants/app_theme/app_theme.dart';
import 'package:tip_calculator/core/constants/screen_size/screen_size.dart';

typedef HistoryType = List<Map<String, dynamic>>;

class HistoryScreen extends StatefulWidget {
  final HistoryType history;

  const HistoryScreen({super.key, required this.history});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> with TickerProviderStateMixin {
  String _sortBy = 'Newest';
  late List<Map<String, dynamic>> _sortedHistory;

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
  title: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Recaps',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: MyColors.blackColor,
        ),
      ),
      SizedBox(
        width: 250, // Adjust width based on screen size
        child: Text(
          'All your past calculations at a glance',
          style: TextStyle(
            fontSize: 16,
            color: MyColors.darkGreyColor,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  ),
  automaticallyImplyLeading: false,
  centerTitle: false,
  leadingWidth: 30,
  leading: IconButton(
    onPressed: () {
      Navigator.pop(context);
    },
    icon: Icon(Icons.arrow_back_ios_new, color: MyColors.blackColor),
  ),
  actionsPadding: EdgeInsets.only(right: 10),
  actions: [
    PopupMenuButton<String>(
      color: MyColors.whiteColor,
      icon: Icon(Icons.tune_rounded, color: MyColors.blackColor, size: 24),
      padding: EdgeInsets.zero, // Minimize padding
      onSelected: (String newValue) {
        setState(() {
          _sortBy = newValue; // Ensure _sortBy is defined in state
          _sortHistory();
        });
      },
      itemBuilder: (BuildContext context) => ['Newest', 'Oldest']
          .map((String value) => PopupMenuItem<String>(
                value: value,
                child: Text(
                  'Sort by: $value',
                  style: TextStyle(color: MyColors.blackColor),
                ),
              ))
          .toList(),
    ),
  ],
),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: MyColors.whiteColor,
              child: _sortedHistory.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: EdgeInsets.all(4.0),
                      itemCount: _sortedHistory.length,
                      itemBuilder: (context, index) {
                        final entry = _sortedHistory[index];
                        return _buildHistoryCard(entry, index);
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '∅',
            style: TextStyle(
              fontSize: 120,
              fontWeight: FontWeight.bold,
              color: MyColors.darkGreyColor.withValues(alpha: 0.4),
            ),
          ),
          Text(
            'No History Yet!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: MyColors.darkGreyColor,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Start calculating tips to see them here.',
            style: TextStyle(fontSize: 16, color: MyColors.darkGreyColor),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
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

  Widget _buildHistoryCard(Map<String, dynamic> entry, int index) {
    final date = entry['date'] as DateTime;
    final minutesAgo = DateTime.now().difference(date).inMinutes;
    final timeText = minutesAgo < 60
        ? '$minutesAgo min ago'
        : '${(minutesAgo / 60).floor()} hr ago';

    return AnimatedContainer(
      duration: Duration(milliseconds: 500 + (index * 100)),
      curve: Curves.easeOut,
      transform: Matrix4.translationValues(
        0,
        _sortedHistory.length > index ? 0 : 50,
        0,
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: ScreenSize.width,
          decoration: BoxDecoration(
            color: MyColors.secondaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${entry['currency']}${entry['total'].toStringAsFixed(2)} / person',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: MyColors.blackColor,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Bill: ${entry['currency']}${entry['bill'].toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 14,
                              color: MyColors.darkGreyColor,
                            ),
                          ),
                          Text(
                            'Tip: ${entry['currency']}${entry['tip'].toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 14,
                              color: MyColors.darkGreyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Text(
                  timeText,
                  style: TextStyle(
                    fontSize: 14,
                    color: MyColors.darkGreyColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}