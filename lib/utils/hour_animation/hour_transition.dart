import 'package:analog_clock/utils/hour_animation/hour_box.dart';
import 'package:flutter/material.dart';
import 'package:analog_clock/base_clock.dart';

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
        .25 secs before for desired results*/

        vsync: this,
        duration: Duration(seconds: 1, milliseconds: 975));
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

    _opacityController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _opacity = Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: _opacityController, curve: Curves.linear))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
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
    if (_time.second == 58) {
      _radController.forward();
      _opacityController.forward();
    }

    return Opacity(
      opacity: _opacity.value,
      child: Center(
        child: HourBox(
          angleRadians: _time.hour * radiansPerHour + _radians.value,
          theme: widget.theme,
          text: _time.hour % 12 == 0 ? "12" : (_time.hour % 12).toString(),
        ),
      ),
    );
  }
}
