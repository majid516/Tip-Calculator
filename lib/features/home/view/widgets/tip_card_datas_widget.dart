import 'package:flutter/material.dart';
import 'package:tip_calculator/core/constants/app_theme/app_colors.dart';
import 'package:tip_calculator/core/constants/spaces/space.dart';

class TipCardDatasWidget extends StatelessWidget {
  final Map<String, dynamic> entry;
  const TipCardDatasWidget({
    super.key, required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total ${entry['currency']} ${(entry['bill'] + entry['tip'])}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: MyColors.primaryColor,
                  ),
                ),
               Space.hSpace5,
                Text(
                  '${entry['currency']} ${entry['total'].toStringAsFixed(2)} / person',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight:  FontWeight.w500,
                    color: MyColors.blackColor,
                  ),
                ),
              
                Text(
                  'Bill : ${entry['currency']} ${entry['bill'].toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 14,fontWeight:  FontWeight.w500,
                    color: MyColors.blackColor,
                  ),
                ),
                Text(
                  'Tip : ${entry['currency']} ${entry['tip'].toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 14,fontWeight: FontWeight.w500,
                    color: MyColors.blackColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
