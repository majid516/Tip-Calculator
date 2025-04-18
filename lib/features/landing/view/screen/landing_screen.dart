import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tip_calculator/core/constants/app_theme/app_theme.dart';
import 'package:tip_calculator/core/constants/screen_size/screen_size.dart';
import 'package:tip_calculator/core/constants/spaces/space.dart';
import 'package:tip_calculator/features/home/view/screens/home_screen.dart';
import 'package:tip_calculator/features/landing/view/widgets/hollow_star_diamond_painter.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with TickerProviderStateMixin {
  late AnimationController _positionController;
  late AnimationController _rotationController;
  late AnimationController _textController;
  late AnimationController _painterController;

  late Animation<double> _rotationAnimation;
  late Animation<double> _painterAnimation;
  double _currentRotation = 0.0; // Track current rotation angle

  List<String> textLines = [
    'Goal-setting',
    'Dedication',
    'Workflow',
    'Efficiency',
    'Concentration',
    'Discipline',
    'Balance',
    'Productivity',
    'Time Manager',
    'Perfomance',
    'Focus.',
  ];
  int currentTextIndex = -1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Text Animation Controller
    _positionController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: textLines.length * 150),
    );

    // Rotation Controller (complete within 0.8 seconds)
    _rotationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    // Text fade in Controller
    _textController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    // Painter movement Controller
    _painterController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 1.5 * 3.14159).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.easeOut),
    );

    _painterAnimation = Tween<double>(
      begin: -400,
      end: MediaQuery.of(context).size.height * 0.33,
    ).animate(
      CurvedAnimation(parent: _painterController, curve: Curves.linear),
    );

    _positionController.addListener(() {
      double progress = _positionController.value;
      int newIndex = (progress * textLines.length).floor();
      if (newIndex == textLines.length && progress < 1.0) {
        newIndex = textLines.length - 1;
      }
      if (newIndex != currentTextIndex && newIndex < textLines.length) {
        setState(() {
          currentTextIndex = newIndex;
        });
        _textController.reset();
        _textController.forward();
      }

      // Stop rotation animation after 0.5 seconds of position animation
      double elapsedTime = _positionController.value * _positionController.duration!.inMilliseconds;
      if (elapsedTime >= 500 && _rotationController.isAnimating) {
        _smoothlyStopRotation(); // Call smooth stop
      }
    });

    _positionController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          currentTextIndex = textLines.length - 1;
        });
        if (!_textController.isAnimating) {
          _textController.forward();
        }
        _positionController.stop();
      }
    });

    // Update rotation smoothly
    _rotationController.addListener(() {
      setState(() {
        _currentRotation = _rotationAnimation.value;
      });
    });

    _painterController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _painterController.stop();
      }
    });

    // Start the animations
    _positionController.forward();
    _rotationController.forward();
    _painterController.forward();
  }

  // Modified method to smoothly stop the rotation, continue in same direction, and end at 0 angle
  void _smoothlyStopRotation() {
    if (_rotationController.isAnimating) {
      // Get the current rotation value
      double currentValue = _rotationAnimation.value;

      // Stop the current animation
      _rotationController.stop();

      // Calculate the target angle in the same direction (clockwise)
      const double twoPi = 1 * 3.14159;
      // Find the next angle equivalent to 0 modulo 2π, continuing clockwise
      double targetValue = currentValue + (twoPi - (currentValue % twoPi));

      // Create a new animation to decelerate to the target angle
      _rotationAnimation = Tween<double>(
        begin: currentValue,
        end: targetValue, // End at angle equivalent to 0
      ).animate(
        CurvedAnimation(
          parent: _rotationController,
          curve: Curves.decelerate,
        ),
      );

      // Reset and animate to the final position over a short duration
      _rotationController
        ..reset()
        ..duration = Duration(milliseconds: 600) // Duration for smooth stop
        ..forward().then((_) {
          setState(() {
            _currentRotation = 0.0; // Reset to 0 after reaching target
          });
        });
    }
  }

  @override
  void dispose() {
    _positionController.dispose();
    _rotationController.dispose();
    _textController.dispose();
    _painterController.dispose();
    super.dispose();
  }

  void stopAnimation() {
    if (_positionController.isAnimating) {
      _positionController.stop();
    }
    _smoothlyStopRotation(); // Use smooth stop for rotation
    if (_textController.isAnimating) {
      _textController.stop();
    }
    if (_painterController.isAnimating) {
      _painterController.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    const double topPadding = 70.0;
    const double leftPadding = 5.0;
    const double textHeight = 53.0;

    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      body: SingleChildScrollView(
        child: LandingScreenBodyComponents(
          stopAnimation: stopAnimation,
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
          currentRotation: _currentRotation,
        ),
      ),
    );
  }
}


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
    required this.stopAnimation, required this.currentRotation,
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
    return SizedBox(
      height: ScreenSize.height,
      width: ScreenSize.height,
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
          // Time-manager text and button at the bottom
          CustomGetStartedButton(stopAnimation: stopAnimation),
        ],
      ),
    );
  }
}

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
              letterSpacing: -4
            ),
          ),
        ),
      ),
    );
  }
}

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
    required this.leftPadding, required this.currentRotation,
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
            // StarDiamondPainter animation
            RotatingPainterWidget(
              painterAnimation: _painterAnimation,
              currentRotation: currentRotation,
            ),
            // Text animation
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

class RotatingPainterWidget extends StatelessWidget {
  const RotatingPainterWidget({
    super.key,
    required Animation<double> painterAnimation,
    required double currentRotation, // Use current rotation value
  })  : _painterAnimation = painterAnimation,
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
            angle: _currentRotation, // Use the current rotation value
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
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Space.wSpace50,
                  Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.black,
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
