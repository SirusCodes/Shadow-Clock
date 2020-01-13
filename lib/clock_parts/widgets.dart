import 'package:flutter/material.dart';

Text cText({@required String text, double size, @required ThemeData theme}) {
  return Text(
    text,
    style: TextStyle(
      color: theme.primaryColor,
      fontSize: size,
      shadows: [Shadow(color: theme.primaryColor, blurRadius: 10.0)],
    ),
  );
}
