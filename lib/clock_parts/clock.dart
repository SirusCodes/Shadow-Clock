import 'package:analog_clock/clock_parts/hour_fade.dart';
import 'package:flutter/material.dart';
import '../analog_clock.dart';
import '../drawn_hand.dart';

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
          thickness: 16,
          size: 0.9,
          angleRadians: DateTime.now().minute * radiansPerTick,
        ),
        DrawnHand(
          color: customTheme.highlightColor,
          thickness: 18,
          size: 0.6,
          angleRadians: DateTime.now().hour * radiansPerHour +
              (DateTime.now().minute / 60) * radiansPerHour,
        ),
        HourFade(theme: customTheme, fadeIn: true),
        HourFade(theme: customTheme, fadeIn: false),
      ],
    );
  }
}
