import 'package:flutter/material.dart';
import 'package:tip_calculator/core/constants/app_theme/app_theme.dart';
import 'package:tip_calculator/core/constants/screen_size/screen_size.dart';
import 'package:tip_calculator/features/landing/view/screen/landing_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenSize.initialize(context);
    return MaterialApp(
      home: LandingScreen(),
    );
  }
}



class HollowStarDiamondPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = MyColors.secondaryColor
      ..style = PaintingStyle.fill;

    // Center of the canvas
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    
    // Control points for curves
    final curveDepth = size.width * 0.15; // How much the sides curve inward
    final pointDistance = size.width * 0.45; // Distance from center to tip
    
    // Outer path
    final outerPath = Path();
    
    // Start at the top point
    outerPath.moveTo(centerX, centerY - pointDistance);
    
    // Right curve
    outerPath.quadraticBezierTo(
      centerX + curveDepth, centerY,
      centerX + pointDistance, centerY
    );
    
    // Bottom curve
    outerPath.quadraticBezierTo(
      centerX, centerY + curveDepth,
      centerX, centerY + pointDistance
    );
    
    // Left curve
    outerPath.quadraticBezierTo(
      centerX - curveDepth, centerY,
      centerX - pointDistance, centerY
    );
    
    // Back to top
    outerPath.quadraticBezierTo(
      centerX, centerY - curveDepth,
      centerX, centerY - pointDistance
    );
    
    outerPath.close();
    
    // Inner path for the hole
    final innerPath = Path();
    final innerRadius = size.width * 0.12; // Size of the transparent center
    
    // Create a small star in the center
    innerPath.moveTo(centerX, centerY - innerRadius);
    
    innerPath.quadraticBezierTo(
      centerX + innerRadius * 0.3, centerY,
      centerX + innerRadius, centerY
    );
    
    innerPath.quadraticBezierTo(
      centerX, centerY + innerRadius * 0.3,
      centerX, centerY + innerRadius
    );
    
    innerPath.quadraticBezierTo(
      centerX - innerRadius * 0.3, centerY,
      centerX - innerRadius, centerY
    );
    
    innerPath.quadraticBezierTo(
      centerX, centerY - innerRadius * 0.3,
      centerX, centerY - innerRadius
    );
    
    innerPath.close();
    
    // Create a composite path with a hole in the middle
    final combinedPath = Path.combine(
      PathOperation.difference,
      outerPath,
      innerPath,
    );
    
    // Draw the filled shape with a hole
    canvas.drawPath(combinedPath, paint);
    
    // Add a subtle stroke for better visibility
    final strokePaint = Paint()
      ..color  = MyColors.secondaryColor // Darker red for stroke
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0;
    
    canvas.drawPath(combinedPath, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
