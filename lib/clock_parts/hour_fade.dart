import 'dart:async';
import 'dart:math' as maths;
import 'package:flutter/material.dart';
import '../analog_clock.dart';

class HourFade extends StatefulWidget {
  const HourFade({
    Key key,
    @required this.theme,
    @required this.fadeIn,
  }) : super(key: key);
  final ThemeData theme;
  final bool fadeIn;

  @override
  _HourFadeState createState() => _HourFadeState();
}

class _HourFadeState extends State<HourFade>
    with SingleTickerProviderStateMixin {
  DateTime _time = DateTime.now();
  int _hour;
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 6)
            //  - Duration(seconds: _time.second),
            )
          ..repeat();

    _animation = Tween<double>(
      begin: widget.fadeIn ? _time.second / 60 : 1.0 - _time.second / 60,
      end: widget.fadeIn ? 1.0 : 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInExpo,
      reverseCurve: Curves.easeInExpo,
    ))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((listener) {
        if (listener == AnimationStatus.completed) {
          _controller.reverse();
        } else if (listener == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _controller.forward();

    _updateHour();
  }

  _updateHour() {
    setState(() {
      Timer(Duration(seconds: 6), _updateHour);
    });
  }

  @override
  Widget build(BuildContext context) {
    _hour = _time.minute;

    if (widget.fadeIn) {
      _hour = 1 + _hour;
    }

    return Opacity(
      opacity: _animation.value,
      child: Center(
        child: SizedBox.expand(
          child: CustomPaint(
            painter: HourFadePainter(
              handSize: .9,
              angleRadians: _hour * radiansPerHour,
              text: (_hour > 12 ? _hour - 12 : _hour).toString(),
              theme: widget.theme,
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
