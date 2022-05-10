import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamway_demo_quiz/utilities/constants.dart';

///This class needs to be initialized for every base route.
class AppConfig {
  static late MediaQueryData _mediaQueryData;
  static late BuildContext _rootContext;

  ///This method needs to be called for every base route.
  ///It sets the root context and the media query data.
  void setRootContext(BuildContext context) {
    _rootContext = context;
    _init();
  }

  //media query attributes
  static late double screenWidth;
  static late double screenHeight;
  static late double safeAreaTop;
  static late double safeAreaBottom;
  static late bool smallDevice;

  //text size config
  static late double _textSizeMainHeading;
  static late double _textSizeSubHeading;
  static late double _textSizeLarge;
  static late double _textSizeNormal;
  static late double _textSizeSmall;

  ///This function makes sure similar text styles are used throughout the app
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
        _size = _textSizeNormal;
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

  ///This function initialises the media query data and the text size config
  void _init() {
    _mediaQueryData = MediaQuery.of(_rootContext);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

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
  }

  ///Generic confirmation Dialog, catering iOS and Android.
  ///Provide the proceed button text in case of iOS as needed, which defaults to
  ///OK if not provided.
  static Future<bool> showConfirmationDialog({
    required String title,
    required String message,
    String proceedButtonText = 'OK',
  }) async {
    final _title = Text(title);
    final _content = Text(message);

    final _dialog = Platform.isAndroid
        ? AlertDialog(
            title: _title,
            content: _content,
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                onPressed: () => Navigator.pop(_rootContext, false),
              ),
              IconButton(
                icon: const Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                onPressed: () => Navigator.pop(_rootContext, true),
              ),
            ],
          )
        : CupertinoAlertDialog(
            title: _title,
            content: _content,
            actions: [
              CupertinoDialogAction(
                child: const Text('Cancel'),
                onPressed: () => Navigator.pop(_rootContext, false),
              ),
              CupertinoDialogAction(
                child: Text(
                  proceedButtonText,
                  style: AppConfig.getTextStyle(
                    context: _rootContext,
                    textColor: TextColor.danger,
                  ),
                ),
                onPressed: () => Navigator.pop(_rootContext, true),
              ),
            ],
          );
    return await showDialog(
      context: _rootContext,
      builder: (context) => _dialog,
    );
  }

  static void showSuccessSnackBar({
    required String snackBarText,
  }) {
    ScaffoldMessenger.of(_rootContext).showSnackBar(_getSnackbar(
      icon: Icons.check_circle,
      text: snackBarText,
      bgColor: Colors.green,
    ));
  }

  static void showFailureSnackBar({
    required String snackBarText,
  }) {
    ScaffoldMessenger.of(_rootContext).showSnackBar(_getSnackbar(
      icon: Icons.cancel,
      text: snackBarText,
      bgColor: Colors.red,
    ));
  }

  static void showWarningSnackBar({
    required String snackBarText,
  }) {
    ScaffoldMessenger.of(_rootContext).showSnackBar(_getSnackbar(
      icon: Icons.warning,
      text: snackBarText,
      bgColor: Colors.deepOrangeAccent,
    ));
  }

  static SnackBar _getSnackbar({
    required IconData icon,
    required String text,
    required Color bgColor,
  }) {
    return SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(
              text,
              style: AppConfig.getTextStyle(
                context: _rootContext,
                textColor: TextColor.white,
              ),
            ),
          ),
        ],
      ),
      duration: const Duration(seconds: 4),
      backgroundColor: bgColor,
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'Dismiss',
        textColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(_rootContext).hideCurrentSnackBar();
        },
      ),
    );
  }
}
