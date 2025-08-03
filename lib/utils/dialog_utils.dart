import 'package:evently_app/utils/app_color.dart';
import 'package:evently_app/utils/app_style.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoading(
      {required BuildContext context, required String loadingText}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(
              color: AppColor.primaryblueColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              loadingText,
              style: AppStyle.black16meduim,
            )
          ],
        ),
      ),
    );
  }

  static void hideLoading({required BuildContext context}) {
    Navigator.pop(context);
  }

  static void showMessage({
    required BuildContext context,
    required String message,
    String? title,
    String? posActionName,
    Function? posAction,
  }) {
    List<Widget>? actions = [];
    if (posActionName != null) {
      actions.add(TextButton(
        onPressed: () {
          Navigator.pop(context);
          if (posAction != null) {
            posAction.call();
          }
        },
        child: Text(
          posActionName,
          style: AppStyle.black16meduim,
        ),
      ));
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
          message,
          style: AppStyle.black16meduim,
        ),
        title: Text(
          title ?? "",
          style: AppStyle.black16meduim,
        ),
        actions: actions,
      ),
    );
  }
}
