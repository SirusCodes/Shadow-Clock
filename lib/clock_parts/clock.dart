import 'package:analog_clock/utils/dial.dart';
import 'package:analog_clock/utils/hour_animation/hour_transition.dart';
import 'package:flutter/material.dart';
import '../base_clock.dart';
import '../utils/hands/drawn_hand.dart';

class Clock extends StatelessWidget {
  Clock({Key key, @required this.customTheme}) : super(key: key);

  final ThemeData customTheme;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Example of a hand drawn with [CustomPainter].
        DrawnHand(
          color: customTheme.accentColor,
          thickness: 4,
          size: 1,
          angleRadians: DateTime.now().second * radiansPerTick,
        ),
        DrawnHand(
          color: customTheme.highlightColor,
          thickness: 8,
          size: 0.9,
          angleRadians: DateTime.now().minute * radiansPerTick,
        ),
        DrawnHand(
          color: customTheme.highlightColor,
          thickness: 12,
          size: 0.6,
          angleRadians: DateTime.now().hour * radiansPerHour +
              (DateTime.now().minute / 60) * radiansPerHour,
        ),
        HourTransition(theme: customTheme),
        Dial(theme: customTheme),
      ],
    );
  }
}
