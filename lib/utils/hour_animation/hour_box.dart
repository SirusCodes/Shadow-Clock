import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../constants.dart';

class HourBox extends StatelessWidget {
  const HourBox(
      {Key key,
      @required this.angleRadians,
      @required this.theme,
      @required this.text})
      : super(key: key);
  final double angleRadians;
  final ThemeData theme;
  final String text;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      /// getting postion of where hour num should be placed
      final angle = angleRadians - PI / 2.0;
      final length = constraints.maxHeight * 0.5 * 0.8;
      final position = Offset(math.cos(angle), math.sin(angle)) * length;

      return Transform.rotate(
        angle: 0,
        child: Center(
          child: Transform.translate(
            offset: position,
            child: Text(
              text,
              style: TextStyle(
                color: theme.primaryColor,
                shadows: [Shadow(color: theme.primaryColor, blurRadius: 10.0)],
                fontSize: 30.0,
              ),
            ),
          ),
        ),
      );
    });
  }
}
