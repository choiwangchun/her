import 'package:flutter/material.dart';
import 'dart:math' as math;

class ParticleAnimationPainter extends CustomPainter {
  final double animationValue;
  final bool isTransitioning;
  final bool isExpanding;

  ParticleAnimationPainter({
    required this.animationValue,
    this.isTransitioning = false,
    this.isExpanding = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = math.min(size.width, size.height) / 2;
    final paint = Paint()
      ..color = isExpanding ? Color(0xFFDCC2A7) : Colors.white
      ..style = PaintingStyle.fill;

    if (isTransitioning) {
      if (isExpanding) {
        // 점이 원으로 확장되는 애니메이션
        final expandedMaxRadius = maxRadius * 3.3; // 이 값을 조정하여 원의 최대 크기를 늘립니다
        final currentRadius = expandedMaxRadius * animationValue;
        canvas.drawCircle(center, currentRadius, paint);
      } else {
        // 원이 점으로 줄어드는 애니메이션
        final currentRadius = maxRadius * animationValue;
        canvas.drawCircle(center, currentRadius, paint..style = PaintingStyle.stroke..strokeWidth = 2.0);
      }
    } else if (animationValue == 1.0) {
      // 완성된 원 그리기
      final outerPath = Path()..addOval(Rect.fromCircle(center: center, radius: maxRadius * 1.05));
      final innerPath = Path()..addOval(Rect.fromCircle(center: center, radius: maxRadius * 1));
      final holePath = Path.combine(PathOperation.difference, outerPath, innerPath);
      canvas.drawPath(holePath, paint..style = PaintingStyle.fill);
    } else {
      // 파티클 애니메이션
      const particleCount = 200;
      final random = math.Random();

      for (int i = 0; i < particleCount; i++) {
        final angle = random.nextDouble() * 2 * math.pi;
        final radius = maxRadius * animationValue;
        final x = center.dx + radius * math.cos(angle);
        final y = center.dy + radius * math.sin(angle);

        final particleSize = 2.0;
        canvas.drawCircle(Offset(x, y), particleSize, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant ParticleAnimationPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.isTransitioning != isTransitioning ||
        oldDelegate.isExpanding != isExpanding;
  }
}