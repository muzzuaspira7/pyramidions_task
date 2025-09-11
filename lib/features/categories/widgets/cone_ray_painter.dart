import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class ConeRayPainter extends CustomPainter {
  final int buttonsCount;
  final double radius;
  const ConeRayPainter({required this.buttonsCount, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final fillPaint =
        Paint()
          ..color = AppColors.glassTint.withOpacity(0.3)
          ..style = PaintingStyle.fill;

    final borderPaint =
        Paint()
          ..color = AppColors.borderColor.withOpacity(0.6)
          ..strokeWidth = 1.2
          ..style = PaintingStyle.stroke;

    for (int i = 0; i < buttonsCount; i++) {
      final angle = 2 * pi * i / buttonsCount;
      final direction = Offset(cos(angle), sin(angle));
      final perpendicular = Offset(-direction.dy, direction.dx);

      final startWidth = 1.0; 
      final endWidth = 32.0; 

      final p1 = center + perpendicular * startWidth;
      final p2 = center - perpendicular * startWidth;

      final endPoint = center + direction * radius;
      final p3 = endPoint + perpendicular * endWidth;
      final p4 = endPoint - perpendicular * endWidth;

      final path =
          Path()
            ..moveTo(p1.dx, p1.dy)
            ..lineTo(p3.dx, p3.dy)
            ..lineTo(p4.dx, p4.dy)
            ..lineTo(p2.dx, p2.dy)
            ..close();

      canvas.drawPath(path, fillPaint);
      canvas.drawPath(path, borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
