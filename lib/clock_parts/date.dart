import 'package:flutter/material.dart';

class Date extends StatelessWidget {
  Date({
    Key key,
    @required this.theme,
    @required this.date,
  }) : super(key: key);

  final ThemeData theme;
  final DateTime date;

  // weekdays
  final List<String> weekdays = [
    "SUNDAY",
    "MONDAY",
    "TUESDAY",
    "WEDNESDAY",
    "THURSDAY",
    "FRIDAY",
    "SATURDAY"
  ];

  // months
  final List<String> months = [
    "JANUARY",
    "FEBUARY",
    "MARCH",
    "APRIL",
    "MAY",
    "JUNE",
    "JULY",
    "AUGUST",
    "SEPTEMBER",
    "OCTOBER",
    "NOVEMBER",
    "DECEMBER"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // Date
        cText(text: date.day.toString(), size: 70.0),
        // weekday
        cText(text: weekdays[date.weekday], size: 20.0),
        // month, year
        cText(
          text: "${months[date.month - 1]}, ${date.year}",
        )
      ],
    );
  }

  Text cText({String text, double size}) {
    return Text(
      text,
      style: TextStyle(
        color: theme.primaryColor,
        fontSize: size,
        shadows: [Shadow(color: theme.primaryColor, blurRadius: 15.0)],
      ),
    );
  }
}
