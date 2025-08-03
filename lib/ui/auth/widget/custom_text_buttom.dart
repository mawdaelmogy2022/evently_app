import 'package:evently_app/utils/app_color.dart';
import 'package:evently_app/utils/app_style.dart';
import 'package:flutter/material.dart';

class CustomTextButtom extends StatelessWidget {
  CustomTextButtom({super.key, required this.text, required this.onpressed});
  String text;
  void Function() onpressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onpressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              text,
              style: AppStyle.blue16bold.copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: AppColor.primaryblueColor),
            ),
          ],
        ));
  }
}
