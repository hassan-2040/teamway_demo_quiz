import 'package:flutter/material.dart';
import 'package:teamway_demo_quiz/utilities/constants.dart';

///This class needs to be initialized for every base route.
class AppConfig {
  static late MediaQueryData _mediaQueryData;

  //screen info/config
  static late double screenWidth;
  static late double screenHeight;
  static late double safeAreaTop;
  static late double safeAreaBottom;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;
  static late bool smallDevice;

  //text size config
  static late double _textSizeMainHeading;
  static late double _textSizeSubHeading;
  static late double _textSizeLarge;
  static late double _textSizeNormal;
  static late double _textSizeSmall;

  static TextStyle getTextStyle({
    required BuildContext context,
    TextColor? textColor,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    TextSize? textSize,
    TextDecoration? textDecoration,
  }) {
    late final double _size;
    late final Color? _color;

    switch (textSize) {
      case TextSize.main:
        _size = _textSizeMainHeading;
        break;
      case TextSize.sub:
        _size = _textSizeSubHeading;
        break;
      case TextSize.large:
        _size = _textSizeLarge;
        break;
      case TextSize.normal:
        _size = _textSizeNormal;
        break;
      case TextSize.small:
        _size = _textSizeSmall;
        break;
      default:
        _size = 14;
        break;
    }

    switch (textColor) {
      case TextColor.primary:
        _color = Theme.of(context).colorScheme.primary;
        break;
      case TextColor.primaryLight:
        _color = Theme.of(context).primaryColorDark;
        break;
      case TextColor.black:
        _color = Colors.black;
        break;
      case TextColor.white:
        _color = Colors.white;
        break;
      case TextColor.danger:
        _color = Colors.red;
        break;
      case TextColor.disabled:
        _color = Theme.of(context).disabledColor;
        break;
      case TextColor.textButton:
        _color = Colors.blue;
        break;
      default:
        _color = Colors.white;
        break;
    }

    return TextStyle(
      color: _color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      fontSize: _size,
      decoration: textDecoration,
    );
  }

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    if (screenWidth > 300 && screenHeight > 600) {
      smallDevice = false;
    } else {
      smallDevice = true;
    }

    //setting text size based on screen size
    if (smallDevice) {
      _textSizeMainHeading = 23;
      _textSizeSubHeading = 18;
      _textSizeLarge = 15;
      _textSizeNormal = 13;
      _textSizeSmall = 10;
    } else {
      _textSizeMainHeading = 30;
      _textSizeSubHeading = 21;
      _textSizeLarge = 18;
      _textSizeNormal = 16;
      _textSizeSmall = 12;
    }

    safeAreaTop = _mediaQueryData.padding.top;
    safeAreaBottom = _mediaQueryData.padding.bottom;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}
