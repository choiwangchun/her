import 'package:flutter/material.dart';
import 'settings_screen.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  late AnimationController _expandAnimationController;
  late Animation<double> _expandAnimation;
  bool _isExpanding = false;

  @override
  void initState() {
    super.initState();
    _expandAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _expandAnimationController,
      curve: Curves.easeInExpo,
    );
  }

  @override
  void dispose() {
    _expandAnimationController.dispose();
    super.dispose();
  }

  void _startSettingsTransition() {
    setState(() {
      _isExpanding = true;
    });
    _expandAnimationController.forward().then((_) {
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => SettingsScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ).then((_) {
        _expandAnimationController.reset();
        setState(() {
          _isExpanding = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = Color(0xFFDCC2A7);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // 전체 화면 콘텐츠
          Column(
            children: [
              // 앱바 대신 SafeArea 사용
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.settings, color: Colors.black87, size: 28),
                        onPressed: _startSettingsTransition,
                        padding: EdgeInsets.all(8),
                      ),
                    ],
                  ),
                ),
              ),
              // 여기에 채팅 화면의 나머지 콘텐츠를 추가하세요
              Expanded(
                child: Center(
                  child: Text('채팅 화면 콘텐츠'),
                ),
              ),
            ],
          ),
          // 확장 애니메이션 오버레이
          if (_isExpanding)
            AnimatedBuilder(
              animation: _expandAnimation,
              builder: (context, child) {
                return CustomPaint(
                  size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
                  painter: ExpandingCirclePainter(
                    animationValue: _expandAnimation.value,
                    color: Colors.white,
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

class ExpandingCirclePainter extends CustomPainter {
  final double animationValue;
  final Color color;

  ExpandingCirclePainter({required this.animationValue, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width > size.height ? size.width : size.height;
    final currentRadius = maxRadius * animationValue;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, currentRadius, paint);
  }

  @override
  bool shouldRepaint(covariant ExpandingCirclePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}