import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tip_calculator/core/constants/app_theme/app_theme.dart';
import 'package:tip_calculator/core/constants/screen_size/screen_size.dart';
import 'package:tip_calculator/core/constants/spaces/space.dart';
import 'package:tip_calculator/features/home/view/screens/home_screen.dart';

class CustomGetStartedButton extends StatelessWidget {
  final void Function() stopAnimation;
  const CustomGetStartedButton({super.key, required this.stopAnimation});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 60,
      left: 0,
      right: 0,
      child: Center(
        child: GestureDetector(
          onTap: () {
            stopAnimation();
            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(builder: (ctx) => TipCalculatorScreen()),
            );
          },
          child: Container(
            width: ScreenSize.width * 0.95,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: MyColors.blackColor, width: 1),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Space.wSpace50,
                  Text(
                    'Get Started',
                    style: TextStyle(
                      color: MyColors.blackColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Space.wSpace50,
                  Icon(Icons.arrow_forward_ios, size: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
