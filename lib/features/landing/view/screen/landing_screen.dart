import 'package:flutter/material.dart';
import 'package:tip_calculator/core/constants/app_theme/app_theme.dart';
import 'package:tip_calculator/core/constants/screen_size/screen_size.dart';
import 'package:tip_calculator/main.dart';

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
    'Focus',
  ];
  int currentTextIndex = -1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Text Animation Controller
    _positionController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: textLines.length * 300,
      ), // 800ms per text
    );

    // Rotation Controller (Independent from text)
    _rotationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    // Text fade in Controller
    _textController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    // Painter movement Controller (Independent from text)
    _painterController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * 3.14159).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );

    // Independent painter movement animation
    _painterAnimation = Tween<double>(
      begin: -200,
      end: MediaQuery.of(context).size.height * 0.33,
    ).animate(
      CurvedAnimation(parent: _painterController, curve: Curves.easeInOut),
    );

    _positionController.addListener(() {
      // Calculate which text should be active based on position controller
      double progress = _positionController.value;
      int newIndex = (progress * textLines.length).floor();

      // Ensure the last text shows properly
      if (newIndex == textLines.length && progress < 1.0) {
        newIndex = textLines.length - 1;
      }

      if (newIndex != currentTextIndex && newIndex < textLines.length) {
        setState(() {
          currentTextIndex = newIndex;
        });
        // Trigger text animation
        _textController.reset();
        _textController.forward();
      }
    });

    _positionController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Keep the last text visible
        setState(() {
          currentTextIndex = textLines.length - 1;
        });
        if (!_textController.isAnimating) {
          _textController.forward();
        }
        _positionController.stop();
      }
    });

    _painterController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _painterController.stop();
        _rotationController.stop();
      }
    });

    // Start the animations
    _positionController.forward();
    _rotationController.repeat();
    _painterController.forward();
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
    if (_rotationController.isAnimating) {
      _rotationController.stop();
    }
    if (_textController.isAnimating) {
      _textController.stop();
    }
    if (_painterController.isAnimating) {
      _painterController.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    const double topPadding = 70.0; // Top padding for the text container
    const double leftPadding = 10.0; // Left padding for the text container
    const double textHeight = 53.0; // Height for each text item

    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      body: SingleChildScrollView(
        child: LandingScreenBodyComponents(stopAnimation: stopAnimation,topPadding: topPadding, leftPadding: leftPadding, textLines: textLines, currentTextIndex: currentTextIndex, textHeight: textHeight, positionController: _positionController, rotationController: _rotationController, textController: _textController, painterController: _painterController, painterAnimation: _painterAnimation, rotationAnimation: _rotationAnimation),
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
    required Animation<double> rotationAnimation, required this.stopAnimation,
  }) : _positionController = positionController, _rotationController = rotationController, _textController = textController, _painterController = painterController, _painterAnimation = painterAnimation, _rotationAnimation = rotationAnimation;
  final VoidCallback stopAnimation;
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenSize.height,
      width: ScreenSize.height,
      child: Stack(
        children: [
          Padding(
            padding:  EdgeInsets.only(
              top: topPadding,
              left: leftPadding,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < textLines.length; i++)
                  AnimatedOpacityTextWidget(currentTextIndex: currentTextIndex, i: i, textHeight: textHeight, textLines: textLines),
              ],
            ),
          ),
          AnimationWidget(positionController: _positionController, rotationController: _rotationController, textController: _textController, painterController: _painterController, currentTextIndex: currentTextIndex, painterAnimation: _painterAnimation, rotationAnimation: _rotationAnimation, textLines: textLines, topPadding: topPadding, textHeight: textHeight, leftPadding: leftPadding),
          // Time-manager text and button at the bottom
         CustomGetStartedButton(stopAnimation: stopAnimation,),
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
      opacity: currentTextIndex == i ? 0.0 : 0.5,
      duration: Duration(milliseconds: 300),
      child: SizedBox(
        height: textHeight,
        child: FittedBox(
          alignment: Alignment.topLeft,
          fit: BoxFit.scaleDown,
          child: Text(
            textLines[i],
            style: TextStyle(
              height: 1,
              color: MyColors.blackColor,
              fontSize: 53,
              fontWeight: FontWeight.bold,
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
    required this.leftPadding,
  }) : _positionController = positionController, _rotationController = rotationController, _textController = textController, _painterController = painterController, _painterAnimation = painterAnimation, _rotationAnimation = rotationAnimation;

  final AnimationController _positionController;
  final AnimationController _rotationController;
  final AnimationController _textController;
  final AnimationController _painterController;
  final int currentTextIndex;
  final Animation<double> _painterAnimation;
  final Animation<double> _rotationAnimation;
  final List<String> textLines;
  final double topPadding;
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
            RotatingPainterWidget(painterAnimation: _painterAnimation, rotationAnimation: _rotationAnimation),
            // Text animation
            if (currentTextIndex >= 0 &&
                currentTextIndex < textLines.length)
              PositionedTextWidget(topPadding: topPadding, currentTextIndex: currentTextIndex, textHeight: textHeight, leftPadding: leftPadding, textOpacity: textOpacity, textLines: textLines),
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
    required Animation<double> rotationAnimation,
  }) : _painterAnimation = painterAnimation, _rotationAnimation = rotationAnimation;

  final Animation<double> _painterAnimation;
  final Animation<double> _rotationAnimation;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(-100, _painterAnimation.value),
      child: Transform.rotate(
        angle: _rotationAnimation.value,
        child: UnconstrainedBox(
          child: CustomPaint(
            painter: HollowStarDiamondPainter(),
            size: Size(402, 660),
          ),
        ),
      ),
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
              textLines[currentTextIndex],
              style: TextStyle(
                color: MyColors.blackColor,
                height: 1,
                fontSize: 53,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomGetStartedButton extends StatelessWidget {
  final VoidCallback stopAnimation;
  const CustomGetStartedButton({
    super.key, required this.stopAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 70,
      left: 0,
      right: 0,
      child: Center(
        child: GestureDetector(
         onTap: stopAnimation,
          child: Container(
            width: ScreenSize.width*0.8,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
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
