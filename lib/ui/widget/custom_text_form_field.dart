import 'package:evently_app/utils/app_color.dart';
import 'package:evently_app/utils/app_style.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
      required this.hintText,
      this.borderColor = AppColor.grayColor,
      this.hintTextstyle,
      this.prefixIconColor = AppColor.grayColor,
      this.prefixIcon,
      this.sufixIcon = const SizedBox(),
      required this.textEditingController,
      required this.validator,
      this.maxlines});
  Color borderColor;
  String hintText;
  TextStyle? hintTextstyle;
  Widget? prefixIcon;
  Widget sufixIcon;
  Color prefixIconColor;
  TextEditingController textEditingController;
  String? Function(String?)? validator;
  int? maxlines;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxlines ?? 1,
      validator: validator,
      controller: textEditingController,
      decoration: InputDecoration(
        enabledBorder: buildborder(borderColor),
        //errorBorder: buildborder(AppColor.redColor),
        focusedErrorBorder: buildborder(AppColor.redColor),
        focusedBorder: buildborder(borderColor),
        prefixIconColor: prefixIconColor,
        hintText: hintText,
        hintStyle: hintTextstyle ?? AppStyle.gray16meduim,
        prefixIcon: prefixIcon,
        suffixIcon: sufixIcon,
      ),
    );
  }

  InputBorder buildborder(Color borderColor) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: borderColor),
      borderRadius: BorderRadius.circular(16),
    );
  }
}
