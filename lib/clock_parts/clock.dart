import 'package:analog_clock/utils/constants.dart';
import 'package:analog_clock/utils/dial.dart';
import 'package:analog_clock/utils/hour_animation/hour_transition.dart';
import 'package:analog_clock/utils/second_animation/second_transition.dart';
import 'package:flutter/material.dart';
import '../utils/hands/drawn_hand.dart';

class Clock extends StatelessWidget {
  Clock({Key key, @required this.customTheme}) : super(key: key);

  final ThemeData customTheme;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // minutes hand
        DrawnHand(
          color: customTheme.highlightColor,
          thickness: 8,
          size: 0.9,
          angleRadians: DateTime.now().minute * radiansPerTick,
        ),
        // hour hand
        DrawnHand(
          color: customTheme.highlightColor,
          thickness: 12,
          size: 0.6,
          angleRadians: DateTime.now().hour * radiansPerHour +
              (DateTime.now().minute / 60) * radiansPerHour,
        ),
        // Cap present at top of intersection of hr n min hands
        Center(
          child: SizedBox.expand(
            child: CustomPaint(
              painter: CapPainter(customTheme),
            ),
          ),
        ),
        // hour transition
        HourTransition(theme: customTheme),
        // dial
        Dial(theme: customTheme),
        // seconds rotor
        Second(
          angleRadians: DateTime.now().second * radiansPerTick,
          theme: customTheme,
        ),
      ],
    );
  }
}

class CapPainter extends CustomPainter {
  CapPainter(this.theme);
  ThemeData theme;
  @override
  void paint(Canvas canvas, Size size) {
    final center = (Offset.zero & size).center;
    final paint = Paint()
      ..color = theme.primaryColor
      ..maskFilter = MaskFilter.blur(BlurStyle.solid, 10.0);

    canvas.drawCircle(center, 10, paint);
  }

  @override
  bool shouldRepaint(CapPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(CapPainter oldDelegate) => false;
}
