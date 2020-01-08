import 'package:analog_clock/utils/second_animation/second.dart';
import 'package:flutter/material.dart';

class Second extends StatelessWidget {
  const Second({Key key, @required this.angleRadians, @required this.theme})
      : super(key: key);

  final double angleRadians;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
          child: CustomPaint(
        painter: SecondPainter(angleRadians: angleRadians, theme: theme),
      )),
    );
  }
}
