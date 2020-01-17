import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'constants.dart';

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

class HourTransition extends StatefulWidget {
  const HourTransition({Key key, this.theme}) : super(key: key);
  final ThemeData theme;
  @override
  _HourTransitionState createState() => _HourTransitionState();
}

class _HourTransitionState extends State<HourTransition>
    with TickerProviderStateMixin {
  DateTime _time;
  AnimationController _radController, _opacityController;
  Animation _radians, _opacity;

  @override
  void initState() {
    super.initState();
    _radController = AnimationController(
      /* from trial and error i found that 
        there need to animation need to finish 
        .30 secs before for desired results*/

      vsync: this,
      // animation runs for 2 secs and starts 58sec before
      duration: Duration(seconds: 1, milliseconds: 970),
    );

    // rotates the hour num around dial
    _radians = Tween(begin: 0, end: radiansPerHour).animate(
        CurvedAnimation(parent: _radController, curve: Curves.easeInOutBack))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _radController.reset();
        }
      });

    _opacityController = AnimationController(
      vsync: this,
      // runs for 1sec in a direction
      duration: Duration(seconds: 1),
    );
    _opacity = Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: _opacityController, curve: Curves.linear))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // starts to appear after some fading out
          _opacityController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _opacityController.reset();
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _radController.dispose();
    _opacityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _time = DateTime.now();
    if (_time.second == 58 && _time.minute == 59) {
      _radController.forward();
      _opacityController.forward();
    }

    return Opacity(
      opacity: _opacity.value,
      child: Center(
        child: HourBox(
          angleRadians: _time.hour * radiansPerHour + _radians.value,
          theme: widget.theme,
          // on dial nums can be only till 12 hence,
          // taking mod of 12 and if mod is 0 (that's
          // midnight) hence 12
          text: _time.hour % 12 == 0 ? "12" : (_time.hour % 12).toString(),
        ),
      ),
    );
  }
}
