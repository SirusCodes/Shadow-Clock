import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Date extends StatelessWidget {
  Date({Key key, @required this.theme}) : super(key: key);

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // Date
        cText(text: DateTime.now().day.toString(), size: 70.0),
        // weekday
        cText(text: DateFormat.EEEE().format(DateTime.now()), size: 20.0),
        // month, year
        cText(
          text:
              "${DateFormat.MMMM().format(DateTime.now())}, ${DateTime.now().year}",
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
        shadows: [Shadow(color: theme.primaryColor, blurRadius: 10.0)],
      ),
    );
  }
}
