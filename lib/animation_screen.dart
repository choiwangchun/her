import 'package:flutter/material.dart';
import 'particle_animation_painter.dart';
import 'chat_screen.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({Key? key}) : super(key: key);

  @override
  _AnimationScreenState createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> with TickerProviderStateMixin {
  late AnimationController _particleAnimationController;
  late Animation<double> _particleAnimation;
  late AnimationController _buttonAnimationController;
  late Animation<double> _buttonAnimation;
  late AnimationController _shrinkAnimationController;
  late AnimationController _expandAnimationController;
  late Animation<double> _expandAnimation;
  bool _particleAnimationFinished = false;
  bool _isShrinking = false;
  bool _isExpanding = false;

  @override
  void initState() {
    super.initState();

    _particleAnimationController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _particleAnimation = CurvedAnimation(
      parent: _particleAnimationController,
      curve: Curves.easeInOut,
    );

    _particleAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _particleAnimationFinished = true;
        });
        _buttonAnimationController.forward();
      }
    });

    _buttonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _buttonAnimation = CurvedAnimation(
      parent: _buttonAnimationController,
      curve: Curves.easeInOut,
    );

    _shrinkAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _expandAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _expandAnimation = CurvedAnimation(
      parent: _expandAnimationController,
      curve: Curves.easeInExpo,
    );

    _particleAnimationController.forward();
  }

  @override
  void dispose() {
    _particleAnimationController.dispose();
    _buttonAnimationController.dispose();
    _shrinkAnimationController.dispose();
    _expandAnimationController.dispose();
    super.dispose();
  }

  void _startTransition() {
    setState(() {
      _isShrinking = true;
    });
    _shrinkAnimationController.forward().then((_) {
      setState(() {
        _isShrinking = false;
        _isExpanding = true;
      });
      _expandAnimationController.forward().then((_) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => ChatScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCF4942),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: _isShrinking ? _shrinkAnimationController : (_isExpanding ? _expandAnimation : _particleAnimation),
              builder: (context, child) {
                return CustomPaint(
                  size: const Size(300, 300),
                  painter: ParticleAnimationPainter(
                    animationValue: _isShrinking
                        ? 1 - _shrinkAnimationController.value
                        : (_isExpanding
                        ? _expandAnimation.value  // 여기를 수정
                        : (_particleAnimationFinished ? 1.0 : _particleAnimation.value)),
                    isTransitioning: _isShrinking || _isExpanding,
                    isExpanding: _isExpanding,
                  ),
                );
              },
            ),
            if (_particleAnimationFinished && !_isShrinking && !_isExpanding)
              FadeTransition(
                opacity: _buttonAnimation,
                child: ElevatedButton(
                  onPressed: _startTransition,
                  child: const Text('대화하기'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.9),
                    foregroundColor: const Color(0xFFCF4942),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}