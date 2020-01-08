import 'package:flutter/material.dart';
import 'dart:math' as math;

class SecondPainter extends CustomPainter {
  SecondPainter({this.angleRadians, this.theme});

  double angleRadians;
  ThemeData theme;
  @override
  void paint(Canvas canvas, Size size) {
    final center = (Offset.zero & size).center;

    final angle = angleRadians - math.pi / 2.0;
    final length = size.shortestSide - 20.0;

    final linePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round
      ..maskFilter = MaskFilter.blur(BlurStyle.solid, 10.0);

    canvas.drawArc(
        Rect.fromCenter(center: center, width: length, height: length),
        angle - math.pi / 60,
        math.pi / 30,
        false,
        linePaint);
  }

  @override
  bool shouldRepaint(SecondPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(SecondPainter oldDelegate) => false;
}
