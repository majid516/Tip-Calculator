import 'package:flutter/material.dart';
import 'package:tip_calculator/core/constants/app_theme/app_theme.dart';
import 'package:tip_calculator/features/landing/view/widgets/landing_screen_body_components.dart';

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
  double _currentRotation = 0.0; 

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
    _positionController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: textLines.length * 150),
    );

    _rotationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _textController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

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

      double elapsedTime =
          _positionController.value *
          _positionController.duration!.inMilliseconds;
      if (elapsedTime >= 500 && _rotationController.isAnimating) {
        _smoothlyStopRotation(); 
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

    _positionController.forward();
    _rotationController.forward();
    _painterController.forward();
  }

  void _smoothlyStopRotation() {
    if (_rotationController.isAnimating) {
      double currentValue = _rotationAnimation.value;

      _rotationController.stop();

      const double twoPi = 1 * 3.14159;
      double targetValue = currentValue + (twoPi - (currentValue % twoPi));

      _rotationAnimation = Tween<double>(
        begin: currentValue,
        end: targetValue, 
      ).animate(
        CurvedAnimation(parent: _rotationController, curve: Curves.decelerate),
      );

      _rotationController
        ..reset()
        ..duration = Duration(milliseconds: 400) 
        ..forward().then((_) {
          setState(() {
            _currentRotation = 0.0;
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
    _smoothlyStopRotation();
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
