import 'dart:math' as maths;
import 'package:flutter/material.dart';
import '../analog_clock.dart';

class HourFade extends StatelessWidget {
  const HourFade({
    Key key,
    @required this.theme,
    @required this.fadeIn,
  }) : super(key: key);
  final ThemeData theme;
  final bool fadeIn;

  @override
  Widget build(BuildContext context) {
    DateTime _time = DateTime.now();
    int _hour = _time.hour;
    double _opacity = 1.0 - (_time.minute) / 60;

    if (fadeIn) {
      _hour = 1 + _hour;
      _opacity = 1.0 - _opacity;
    }

    return Opacity(
      opacity: _opacity,
      child: Center(
        child: SizedBox.expand(
          child: CustomPaint(
            painter: HourFadePainter(
              handSize: .9,
              angleRadians: _hour * radiansPerHour,
              text: (_hour > 12 ? _hour - 12 : _hour).toString(),
              theme: theme,
            ),
          ),
        ),
      ),
    );
  }
}

class HourFadePainter extends CustomPainter {
  HourFadePainter(
      {@required this.handSize,
      @required this.angleRadians,
      @required this.text,
      @required this.theme});

  double handSize;
  double angleRadians;
  String text;
  ThemeData theme;

  @override
  void paint(Canvas canvas, Size size) {
    final center = (Offset.zero & size).center;
    // We want to start at the top, not at the x-axis, so add pi/2.
    final angle = angleRadians - maths.pi / 2.0;
    final length = size.shortestSide * 0.5 * handSize;
    final position =
        center + Offset(maths.cos(angle), maths.sin(angle)) * length;
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: theme.primaryColor,
          shadows: [Shadow(color: theme.primaryColor, blurRadius: 10.0)],
          fontSize: 30.0,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, position);
  }

  @override
  bool shouldRepaint(HourFadePainter oldDelegate) =>
      oldDelegate.angleRadians != angleRadians;
}
