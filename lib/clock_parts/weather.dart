import 'package:analog_clock/clock_parts/widgets.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class Weather extends StatelessWidget {
  Weather(this.theme, this.condition, this.temperature, this.temperatureRange,
      this.location);
  final ThemeData theme;
  final String temperature;
  final String temperatureRange;
  final String condition;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // flare animation
        SizedBox(
          height: 67.0,
          width: 67.0,
          child: FlareActor(
            "assets/$condition.flr",
            animation: "animation",
          ),
        ),
        // temperature
        cText(text: temperature, theme: theme, size: 25),
        // temprature range
        cText(text: temperatureRange, theme: theme, size: 11),
        // location
        cText(text: location, theme: theme, size: 15),
      ],
    );
  }
}
