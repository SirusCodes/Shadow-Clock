import 'package:analog_clock/clock_parts/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Date extends StatelessWidget {
  Date({Key key, @required this.theme}) : super(key: key);

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          // Date
          cText(text: DateTime.now().day.toString(), size: 70.0, theme: theme),
          // weekday
          cText(
              text: DateFormat.EEEE().format(DateTime.now()),
              size: 25.0,
              theme: theme),
          // month, year
          cText(
              text:
                  "${DateFormat.MMMM().format(DateTime.now())}, ${DateTime.now().year}",
              theme: theme,
              size: 20.0)
        ],
      ),
    );
  }
}
