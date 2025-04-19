import 'package:flutter/cupertino.dart';
import 'package:tip_calculator/features/landing/view/widgets/mobile_view.dart';
import 'package:tip_calculator/features/landing/view/widgets/web_view.dart';

class LandingScreenBodyComponents extends StatelessWidget {
  const LandingScreenBodyComponents({
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
    required this.stopAnimation,
    required this.currentRotation,
  }) : _positionController = positionController,
       _rotationController = rotationController,
       _textController = textController,
       _painterController = painterController,
       _painterAnimation = painterAnimation,
       _rotationAnimation = rotationAnimation;

  final VoidCallback stopAnimation;
  final double topPadding;
  final double leftPadding;
  final List<String> textLines;
  final int currentTextIndex;
  final double textHeight;
  final double currentRotation;
  final AnimationController _positionController;
  final AnimationController _rotationController;
  final AnimationController _textController;
  final AnimationController _painterController;
  final Animation<double> _painterAnimation;
  final Animation<double> _rotationAnimation;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return WebView(
            topPadding: topPadding,
            leftPadding: leftPadding,
            textLines: textLines,
            currentTextIndex: currentTextIndex,
            textHeight: textHeight,
            positionController: _positionController,
            rotationController: _rotationController,
            textController: _textController,
            painterController: _painterController,
            painterAnimation: _painterAnimation,
            rotationAnimation: _rotationAnimation,
            currentRotation: currentRotation,
            stopAnimation: stopAnimation,
          );
        } else {
          return MobileView(
            topPadding: topPadding,
            leftPadding: leftPadding,
            textLines: textLines,
            currentTextIndex: currentTextIndex,
            textHeight: textHeight,
            positionController: _positionController,
            rotationController: _rotationController,
            textController: _textController,
            painterController: _painterController,
            painterAnimation: _painterAnimation,
            rotationAnimation: _rotationAnimation,
            currentRotation: currentRotation,
            stopAnimation: stopAnimation,
          );
        }
      },
    );
  }
}
