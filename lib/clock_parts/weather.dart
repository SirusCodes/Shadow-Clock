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
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 100.0,
              width: 130.0,
              child: FlareActor(
                "assets/$condition.flr",
                animation: "animation",
              ),
            ),
            Column(
              children: <Widget>[
                cText(text: temperature, theme: theme, size: 30),
                cText(text: temperatureRange, theme: theme, size: 15),
              ],
            )
          ],
        ),
        cText(text: location, theme: theme, size: 18),
      ],
    );
  }
}
