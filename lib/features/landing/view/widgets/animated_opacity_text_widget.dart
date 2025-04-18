import 'package:flutter/cupertino.dart';
import 'package:tip_calculator/core/constants/app_theme/app_theme.dart';

class AnimatedOpacityTextWidget extends StatelessWidget {
  const AnimatedOpacityTextWidget({
    super.key,
    required this.currentTextIndex,
    required this.i,
    required this.textHeight,
    required this.textLines,
  });

  final int currentTextIndex;
  final int i;
  final double textHeight;
  final List<String> textLines;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: currentTextIndex == i ? 0.0 : 0.25,
      duration: Duration(milliseconds: 300),
      child: SizedBox(
        height: textHeight,
        child: FittedBox(
          alignment: Alignment.topLeft,
          fit: BoxFit.scaleDown,
          child: Text(
            maxLines: 1,
            textLines[i],
            style: TextStyle(
              height: 0.8,
              color: MyColors.blackColor,
              fontSize: 60,
              fontWeight: FontWeight.w500,
              letterSpacing: -4,
            ),
          ),
        ),
      ),
    );
  }
}
