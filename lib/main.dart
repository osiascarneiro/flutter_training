import 'package:first_flutter_app/flutter_maps/quakes/quakes_app.dart';
import 'package:flutter/material.dart';

final ThemeData _appTheme = _buildAppTheme();

ThemeData _buildAppTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    brightness: Brightness.dark,
    accentColor: Colors.amber,
    primaryColor: Colors.green,
    scaffoldBackgroundColor: Colors.red,
    backgroundColor: Colors.amber,
    textTheme: _appTextTheme(base.textTheme)
  );
}

TextTheme _appTextTheme(TextTheme base) {
  return base.copyWith(
    headline5:  base.headline5.copyWith(
      fontWeight: FontWeight.w500
    ),
    headline6: base.headline6.copyWith(
      fontSize: 18
    ),
    caption: base.caption.copyWith(
      fontWeight: FontWeight.w400,
        fontSize: 14
    ),
    button: base.button.copyWith(
      fontSize: 23.9
    ),
    bodyText2: base.bodyText2.copyWith(
        fontSize: 16.9,
        color: Colors.white
    )
  );
}

void main() => runApp(new MaterialApp(
  home: QuakesApp(),
  // theme: _appTheme,
));

