import 'package:flutter/material.dart';


//Theme Colors for the app
const Color primaryColorDark = Color(0xFF05316e);
const accentColor = Color(0xFF1b76f5);
const MaterialColor themeColor = MaterialColor(0xFF0e4188, _color);
const Map<int, Color> _color = {
  50: Color.fromRGBO(14, 65, 136, .1),
  100: Color.fromRGBO(14, 65, 136, .2),
  200: Color.fromRGBO(14, 65, 136, .3),
  300: Color.fromRGBO(14, 65, 136, .4),
  400: Color.fromRGBO(14, 65, 136, .5),
  500: Color.fromRGBO(14, 65, 136, .6),
  600: Color.fromRGBO(14, 65, 136, .7),
  700: Color.fromRGBO(14, 65, 136, .8),
  800: Color.fromRGBO(14, 65, 136, .9),
  900: Color.fromRGBO(14, 65, 136, 1),
};

//Enums
enum TextSize {
  main,
  sub,
  large,
  normal,
  small,
}

enum TextColor {
  primary,
  primaryLight,
  black,
  white,
  danger, //red
  disabled,
  textButton //blue for raw text buttons such as hyperlink
}

