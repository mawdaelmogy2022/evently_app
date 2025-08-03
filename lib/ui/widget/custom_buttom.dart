import 'package:evently_app/utils/app_color.dart';
import 'package:evently_app/utils/app_style.dart';
import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  CustomButtom({
    super.key,
    this.backgroundColor = AppColor.primaryblueColor,
    this.textStyle,
    this.imageIcon = false,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.colorborder = AppColor.primaryblueColor,
    this.imageIconUrl,
    required this.text,
    required this.onpressed,
  });
  String text;
  TextStyle? textStyle;
  void Function() onpressed;
  Color backgroundColor;
  bool imageIcon;
  String? imageIconUrl;
  MainAxisAlignment mainAxisAlignment;
  Color colorborder;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: EdgeInsets.symmetric(vertical: size.height * .02),
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: colorborder),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: onpressed,
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: [
              imageIcon == true ? Image.asset(imageIconUrl!) : const SizedBox(),
              SizedBox(
                width: size.width * .01,
              ),
              Text(
                text,
                style: textStyle ?? AppStyle.white20meduim,
              ),
            ],
          )),
    );
  }
}
