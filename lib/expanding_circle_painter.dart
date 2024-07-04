import 'package:flutter/material.dart';

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