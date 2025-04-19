import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:tip_calculator/core/constants/app_theme/app_colors.dart';
import 'package:tip_calculator/core/constants/screen_size/screen_size.dart';
import 'package:tip_calculator/features/home/view/screens/home_screen.dart';

class BottomControlsWidget extends StatelessWidget {
  final void Function() reset;
  final void Function() saveHistory;
  const BottomControlsWidget({
    super.key,
    required this.reset,
    required this.saveHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: ScreenSize.width,
        height: 100,
        decoration: BoxDecoration(
          color: MyColors.ternaryColor.withValues(alpha: 0.6),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Showcase(
              key: resetKey,
              description: 'Reset Button',
              child: ElevatedButton(
                onPressed: reset,
                style: 
                // Theme.of(context).elevatedButtonTheme.style?.copyWith(
                //   padding: WidgetStateProperty.resolveWith((_)=> const EdgeInsets.symmetric(
                //     vertical: 12,
                //     horizontal: 20,
                //   ),),
                //   fixedSize: WidgetStateProperty.resolveWith((_)=>Size(ScreenSize.width * 0.4, 45)),
                // )
                ElevatedButton.styleFrom(
                  side: const BorderSide(width: 2, color: MyColors.primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fixedSize: Size(ScreenSize.width * 0.4, 45),
                  backgroundColor: MyColors.whiteColor,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 20,
                  ),
                ),
                child: const Text(
                  'Reset',
                  style: TextStyle(color: MyColors.blackColor),
                ),
              ),
            ),
            Showcase(
              key: saveKey,
              description: 'Save Button',
              child: ElevatedButton(
                onPressed: saveHistory,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  fixedSize: Size(ScreenSize.width * 0.4, 45),
                  backgroundColor: MyColors.primaryColor,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 20,
                  ),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(color: MyColors.whiteColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
