import 'package:flutter/material.dart';
import '../analog_clock.dart';
import '../drawn_hand.dart';

class Clock extends StatelessWidget {
  Clock({
    Key key,
    @required this.customTheme,
    @required DateTime now,
  })  : _now = now,
        super(key: key);

  final ThemeData customTheme;
  final DateTime _now;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Example of a hand drawn with [CustomPainter].
        DrawnHand(
          color: customTheme.accentColor,
          thickness: 4,
          size: 1,
          angleRadians: _now.second * radiansPerTick,
        ),
        DrawnHand(
          color: customTheme.highlightColor,
          thickness: 16,
          size: 0.9,
          angleRadians: _now.minute * radiansPerTick,
        ),
        DrawnHand(
          color: customTheme.highlightColor,
          thickness: 18,
          size: 0.6,
          angleRadians:
              _now.hour * radiansPerHour + (_now.minute / 60) * radiansPerHour,
        ),
      ],
    );
  }
}
