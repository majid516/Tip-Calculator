import 'package:flutter/cupertino.dart';
import 'package:tip_calculator/core/constants/screen_size/screen_size.dart';
import 'package:tip_calculator/features/landing/view/widgets/animated_opacity_text_widget.dart';
import 'package:tip_calculator/features/landing/view/widgets/animation_widget.dart';
import 'package:tip_calculator/features/landing/view/widgets/custom_get_started_button.dart';

class MobileView extends StatelessWidget {
  const MobileView({
    super.key,
    required this.topPadding,
    required this.leftPadding,
    required this.textLines,
    required this.currentTextIndex,
    required this.textHeight,
    required AnimationController positionController,
    required AnimationController rotationController,
    required AnimationController textController,
    required AnimationController painterController,
    required Animation<double> painterAnimation,
    required Animation<double> rotationAnimation,
    required this.currentRotation,
    required this.stopAnimation,
  }) : _positionController = positionController, _rotationController = rotationController, _textController = textController, _painterController = painterController, _painterAnimation = painterAnimation, _rotationAnimation = rotationAnimation;

  final double topPadding;
  final double leftPadding;
  final List<String> textLines;
  final int currentTextIndex;
  final double textHeight;
  final AnimationController _positionController;
  final AnimationController _rotationController;
  final AnimationController _textController;
  final AnimationController _painterController;
  final Animation<double> _painterAnimation;
  final Animation<double> _rotationAnimation;
  final double currentRotation;
  final VoidCallback stopAnimation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenSize.height,
      width: ScreenSize.width,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: topPadding, left: leftPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < textLines.length; i++)
                  AnimatedOpacityTextWidget(
                    currentTextIndex: currentTextIndex,
                    i: i,
                    textHeight: textHeight,
                    textLines: textLines,
                  ),
              ],
            ),
          ),
          AnimationWidget(
            positionController: _positionController,
            rotationController: _rotationController,
            textController: _textController,
            painterController: _painterController,
            currentTextIndex: currentTextIndex,
            painterAnimation: _painterAnimation,
            rotationAnimation: _rotationAnimation,
            textLines: textLines,
            topPadding: topPadding,
            textHeight: textHeight,
            leftPadding: leftPadding,
            currentRotation: currentRotation,
          ),
          CustomGetStartedButton(stopAnimation: stopAnimation),
        ],
      ),
    );
  }
}
