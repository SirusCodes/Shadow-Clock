import 'package:flutter/material.dart';
import 'dart:math' as math;

class Dial extends StatelessWidget {
  const Dial({Key key, this.theme}) : super(key: key);
  final ThemeData theme;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: DialPainter(theme),
        ),
      ),
    );
  }
}

class DialPainter extends CustomPainter {
  DialPainter(this.theme);
  final ThemeData theme;

  @override
  void paint(Canvas canvas, Size size) {
    final center = (Offset.zero & size).center;

    final paintCircle = Paint()
      ..color = theme.primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..maskFilter = MaskFilter.blur(BlurStyle.solid, 10.0);
    canvas.drawCircle(center, size.height / 2 - 10.0, paintCircle);

    for (double angleRad = 0; angleRad < 2 * math.pi; angleRad += math.pi / 6) {
      final angle = angleRad - math.pi / 2.0;
      final length = size.shortestSide * 0.5 - 10.0;
      final position1 =
          center + Offset(math.cos(angle), math.sin(angle)) * length;
      final position2 =
          center + Offset(math.cos(angle), math.sin(angle)) * (length - 5.0);
      final paintStroke = Paint()
        ..color = theme.primaryColor
        ..strokeWidth = 3.0
        ..maskFilter = MaskFilter.blur(BlurStyle.solid, 10.0);
      canvas.drawLine(position1, position2, paintStroke);
    }
  }

  @override
  bool shouldRepaint(DialPainter oldDelegate) => oldDelegate.theme != theme;
}
