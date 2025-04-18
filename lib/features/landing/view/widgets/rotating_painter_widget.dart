import 'package:flutter/cupertino.dart';
import 'package:tip_calculator/features/landing/view/widgets/hollow_star_diamond_painter.dart';

class RotatingPainterWidget extends StatelessWidget {
  const RotatingPainterWidget({
    super.key,
    required Animation<double> painterAnimation,
    required double currentRotation, 
  }) : _painterAnimation = painterAnimation,
       _currentRotation = currentRotation;

  final Animation<double> _painterAnimation;
  final double _currentRotation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: -200,
          top: _painterAnimation.value,
          child: Transform.rotate(
            angle: _currentRotation, 
            child: CustomPaint(
              painter: HollowStarDiamondPainter(),
              size: Size(600, 660),
            ),
          ),
        ),
      ],
    );
  }
}
