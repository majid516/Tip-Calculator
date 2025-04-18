import 'package:flutter/material.dart';
import 'package:tip_calculator/core/constants/app_theme/app_theme.dart';

class HollowStarDiamondPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = MyColors.secondaryColor
          ..style = PaintingStyle.fill;

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final curveDepth = size.width * 0.09;
    final pointDistance = size.width * 0.45;
    final innerRadius = size.width * 0.12;
    final innerCurveDepth = innerRadius * 0.2;

    final topOuterPoint = Offset(centerX, centerY - pointDistance);
    final rightOuterPoint = Offset(centerX + pointDistance, centerY);
    final bottomOuterPoint = Offset(centerX, centerY + pointDistance);
    final leftOuterPoint = Offset(centerX - pointDistance, centerY);

    final topInnerPoint = Offset(centerX, centerY - innerRadius);
    final rightInnerPoint = Offset(centerX + innerRadius, centerY);
    final bottomInnerPoint = Offset(centerX, centerY + innerRadius);
    final leftInnerPoint = Offset(centerX - innerRadius, centerY);

    final topRightOuterControl = Offset(
      centerX + curveDepth,
      centerY - curveDepth,
    );
    final topLeftOuterControl = Offset(
      centerX - curveDepth,
      centerY - curveDepth,
    );
    final bottomRightOuterControl = Offset(
      centerX + curveDepth,
      centerY + curveDepth,
    );
    final bottomLeftOuterControl = Offset(
      centerX - curveDepth,
      centerY + curveDepth,
    );

    final topRightInnerControl = Offset(
      centerX + innerCurveDepth,
      centerY - innerCurveDepth,
    );
    final topLeftInnerControl = Offset(
      centerX - innerCurveDepth,
      centerY - innerCurveDepth,
    );
    final bottomRightInnerControl = Offset(
      centerX + innerCurveDepth,
      centerY + innerCurveDepth,
    );
    final bottomLeftInnerControl = Offset(
      centerX - innerCurveDepth,
      centerY + innerCurveDepth,
    );

    final topRightPath = Path();
    topRightPath.moveTo(centerX, centerY);
    topRightPath.lineTo(topInnerPoint.dx, topInnerPoint.dy);
    topRightPath.quadraticBezierTo(
      topRightInnerControl.dx,
      topRightInnerControl.dy,
      rightInnerPoint.dx,
      rightInnerPoint.dy,
    );
    topRightPath.lineTo(centerX, centerY);
    topRightPath.close();

    final topRightOuterPath = Path();
    topRightOuterPath.moveTo(centerX, centerY);
    topRightOuterPath.lineTo(topOuterPoint.dx, topOuterPoint.dy);
    topRightOuterPath.quadraticBezierTo(
      topRightOuterControl.dx,
      topRightOuterControl.dy,
      rightOuterPoint.dx,
      rightOuterPoint.dy,
    );
    topRightOuterPath.lineTo(centerX, centerY);
    topRightOuterPath.close();

    final combinedTopRightPath = Path.combine(
      PathOperation.difference,
      topRightOuterPath,
      topRightPath,
    );

    canvas.drawPath(combinedTopRightPath, paint);

    final bottomRightPath = Path();
    bottomRightPath.moveTo(centerX, centerY);
    bottomRightPath.lineTo(rightInnerPoint.dx, rightInnerPoint.dy);
    bottomRightPath.quadraticBezierTo(
      bottomRightInnerControl.dx,
      bottomRightInnerControl.dy,
      bottomInnerPoint.dx,
      bottomInnerPoint.dy,
    );
    bottomRightPath.lineTo(centerX, centerY);
    bottomRightPath.close();

    final bottomRightOuterPath = Path();
    bottomRightOuterPath.moveTo(centerX, centerY);
    bottomRightOuterPath.lineTo(rightOuterPoint.dx, rightOuterPoint.dy);
    bottomRightOuterPath.quadraticBezierTo(
      bottomRightOuterControl.dx,
      bottomRightOuterControl.dy,
      bottomOuterPoint.dx,
      bottomOuterPoint.dy,
    );
    bottomRightOuterPath.lineTo(centerX, centerY);
    bottomRightOuterPath.close();

    final combinedBottomRightPath = Path.combine(
      PathOperation.difference,
      bottomRightOuterPath,
      bottomRightPath,
    );

    canvas.drawPath(combinedBottomRightPath, paint);

    final bottomLeftPath = Path();
    bottomLeftPath.moveTo(centerX, centerY);
    bottomLeftPath.lineTo(bottomInnerPoint.dx, bottomInnerPoint.dy);
    bottomLeftPath.quadraticBezierTo(
      bottomLeftInnerControl.dx,
      bottomLeftInnerControl.dy,
      leftInnerPoint.dx,
      leftInnerPoint.dy,
    );
    bottomLeftPath.lineTo(centerX, centerY);
    bottomLeftPath.close();

    final bottomLeftOuterPath = Path();
    bottomLeftOuterPath.moveTo(centerX, centerY);
    bottomLeftOuterPath.lineTo(bottomOuterPoint.dx, bottomOuterPoint.dy);
    bottomLeftOuterPath.quadraticBezierTo(
      bottomLeftOuterControl.dx,
      bottomLeftOuterControl.dy,
      leftOuterPoint.dx,
      leftOuterPoint.dy,
    );
    bottomLeftOuterPath.lineTo(centerX, centerY);
    bottomLeftOuterPath.close();

    final combinedBottomLeftPath = Path.combine(
      PathOperation.difference,
      bottomLeftOuterPath,
      bottomLeftPath,
    );

    canvas.drawPath(combinedBottomLeftPath, paint);

    final topLeftPath = Path();
    topLeftPath.moveTo(centerX, centerY);
    topLeftPath.lineTo(leftInnerPoint.dx, leftInnerPoint.dy);
    topLeftPath.quadraticBezierTo(
      topLeftInnerControl.dx,
      topLeftInnerControl.dy,
      topInnerPoint.dx,
      topInnerPoint.dy,
    );
    topLeftPath.lineTo(centerX, centerY);
    topLeftPath.close();

    final topLeftOuterPath = Path();
    topLeftOuterPath.moveTo(centerX, centerY);
    topLeftOuterPath.lineTo(leftOuterPoint.dx, leftOuterPoint.dy);
    topLeftOuterPath.quadraticBezierTo(
      topLeftOuterControl.dx,
      topLeftOuterControl.dy,
      topOuterPoint.dx,
      topOuterPoint.dy,
    );
    topLeftOuterPath.lineTo(centerX, centerY);
    topLeftOuterPath.close();

    final combinedTopLeftPath = Path.combine(
      PathOperation.difference,
      topLeftOuterPath,
      topLeftPath,
    );

    canvas.drawPath(combinedTopLeftPath, paint);

    final strokePaint =
        Paint()
          ..color = MyColors.primaryColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5;

    canvas.drawLine(topInnerPoint, topOuterPoint, strokePaint);
    canvas.drawLine(rightInnerPoint, rightOuterPoint, strokePaint);
    canvas.drawLine(bottomInnerPoint, bottomOuterPoint, strokePaint);
    canvas.drawLine(leftInnerPoint, leftOuterPoint, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
