// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:analog_clock/clock_parts/date.dart';
import 'package:analog_clock/clock_parts/weather.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:intl/intl.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

import 'clock_parts/clock.dart';

/// Total distance traveled by a second or a minute hand, each second or minute,
/// respectively.
final radiansPerTick = radians(360 / 60);

/// Total distance traveled by an hour hand, each hour, in radians.
final radiansPerHour = radians(360 / 12);

/// A basic analog clock.
///
/// You can do better than this!
class AnalogClock extends StatefulWidget {
  const AnalogClock(this.model);

  final ClockModel model;

  @override
  _AnalogClockState createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  var _temperature = '';
  var _temperatureRange = '';
  var _condition = '';
  var _location = '';

  var _now = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    // Set the initial values.
    widget.model.addListener(_updateModel);
    _updateModel();
    _updateTime();
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    super.dispose();
  }

  @override
  void didUpdateWidget(AnalogClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      // Update once per second. Make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }

  void _updateModel() {
    setState(() {
      _temperature = widget.model.temperatureString;
      _temperatureRange = '${widget.model.low} - ${widget.model.highString}';
      _condition = widget.model.weatherString;
      _location = widget.model.location;
    });
  }

  @override
  Widget build(BuildContext context) {
    // There are many ways to apply themes to your clock. Some are:
    //  - Inherit the parent Theme (see ClockCustomizer in the
    //    flutter_clock_helper package).
    //  - Override the Theme.of(context).colorScheme.
    //  - Create your own [ThemeData], demonstrated in [AnalogClock].
    //  - Create a map of [Color]s to custom keys, demonstrated in
    //    [DigitalClock].
    final customTheme = Theme.of(context).brightness == Brightness.light
        ? Theme.of(context).copyWith(
            // Hour hand.
            primaryColor: Colors.black,
            // Minute hand.
            highlightColor: Colors.black,
            // Second hand.
            accentColor: Colors.black,
            backgroundColor: Colors.white,
          )
        : Theme.of(context).copyWith(
            primaryColor: Colors.white,
            highlightColor: Colors.white,
            accentColor: Colors.white,
            backgroundColor: Colors.black,
          );

    final time = DateFormat.Hms().format(DateTime.now());

    return Semantics.fromProperties(
      properties: SemanticsProperties(
        label: 'Analog clock with time $time',
        value: time,
      ),
      child: Container(
        color: customTheme.backgroundColor,
        child: Row(
          children: <Widget>[
            // clock hands
            Expanded(
              flex: 5,
              child: Clock(customTheme: customTheme),
            ),
            // date and weather
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // show weather and other info
                  Weather(
                    customTheme,
                    _condition,
                    _temperature,
                    _temperatureRange,
                    _location,
                  ),
                  // show date
                  Date(theme: customTheme),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
