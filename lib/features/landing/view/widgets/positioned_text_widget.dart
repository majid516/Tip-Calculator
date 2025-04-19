import 'package:flutter/cupertino.dart';
import 'package:tip_calculator/core/constants/app_theme/app_colors.dart';

class PositionedTextWidget extends StatelessWidget {
  const PositionedTextWidget({
    super.key,
    required this.topPadding,
    required this.currentTextIndex,
    required this.textHeight,
    required this.leftPadding,
    required this.textOpacity,
    required this.textLines,
  });

  final double topPadding;
  final int currentTextIndex;
  final double textHeight;
  final double leftPadding;
  final double textOpacity;
  final List<String> textLines;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topPadding + (currentTextIndex * textHeight),
      left: leftPadding,
      right: 0,
      child: Opacity(
        opacity: textOpacity,
        child: SizedBox(
          height: textHeight,
          child: FittedBox(
            alignment: Alignment.topLeft,
            fit: BoxFit.scaleDown,
            child: Text(
              maxLines: 1,
              textLines[currentTextIndex],
              style: TextStyle(
                color: MyColors.blackColor,
                height: 0.8,
                fontSize: 60,
                letterSpacing: -4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
