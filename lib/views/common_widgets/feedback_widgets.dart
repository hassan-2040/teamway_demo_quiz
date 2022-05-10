import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamway_demo_quiz/utilities/app_config.dart';
import 'package:teamway_demo_quiz/utilities/constants.dart';

class FeedbackWidgets {
  static late BuildContext _rootContext;

  void setRootContext(BuildContext context) {
    _rootContext = context;
  }
  //TODO remove this if not needed
  // static void showLoading() {
  //   showGeneralDialog(
  //     context: _rootContext,
  //     barrierColor: AppConfig.primaryColor.withOpacity(0.5),
  //     barrierDismissible: false,
  //     barrierLabel: '',
  //     pageBuilder: (ctx, _, __) {
  //       return const Center(
  //         child: SizedBox(
  //           height: 30,
  //           width: 30,
  //           child: CircularProgressIndicator(
  //             color: AppConfig.primaryColor,
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  ///Generic confirmation Dialog, catering iOS and Android.
  ///Provide the proceed button text in case of iOS, which defaults to
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
