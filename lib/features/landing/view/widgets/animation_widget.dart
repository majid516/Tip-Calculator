import 'package:flutter/cupertino.dart';
import 'package:tip_calculator/features/landing/view/widgets/positioned_text_widget.dart';
import 'package:tip_calculator/features/landing/view/widgets/rotating_painter_widget.dart';

class AnimationWidget extends StatelessWidget {
  const AnimationWidget({
    super.key,
    required AnimationController positionController,
    required AnimationController rotationController,
    required AnimationController textController,
    required AnimationController painterController,
    required this.currentTextIndex,
    required Animation<double> painterAnimation,
    required Animation<double> rotationAnimation,
    required this.textLines,
    required this.topPadding,
    required this.textHeight,
    required this.leftPadding,
    required this.currentRotation,
  }) : _positionController = positionController,
       _rotationController = rotationController,
       _textController = textController,
       _painterController = painterController,
       _painterAnimation = painterAnimation;

  final AnimationController _positionController;
  final AnimationController _rotationController;
  final AnimationController _textController;
  final AnimationController _painterController;
  final int currentTextIndex;
  final Animation<double> _painterAnimation;

  final List<String> textLines;
  final double topPadding;
  final double currentRotation;
  final double textHeight;
  final double leftPadding;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _positionController,
        _rotationController,
        _textController,
        _painterController,
      ]),
      builder: (context, child) {
        double textOpacity =
            currentTextIndex >= 0
                ? Curves.easeIn.transform(_textController.value)
                : 0;

        return Stack(
          children: [
            RotatingPainterWidget(
              painterAnimation: _painterAnimation,
              currentRotation: currentRotation,
            ),
            if (currentTextIndex >= 0 && currentTextIndex < textLines.length)
              PositionedTextWidget(
                topPadding: topPadding,
                currentTextIndex: currentTextIndex,
                textHeight: textHeight,
                leftPadding: leftPadding,
                textOpacity: textOpacity,
                textLines: textLines,
              ),
          ],
        );
      },
    );
  }
}
