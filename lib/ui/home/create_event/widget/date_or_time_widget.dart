import 'package:evently_app/ui/auth/widget/custom_text_buttom.dart';
import 'package:evently_app/utils/app_style.dart';
import 'package:flutter/material.dart';

class DateOrTimeWidget extends StatelessWidget {
  DateOrTimeWidget(
      {required this.iconImage,
      required this.textDateOrTime,
      required this.chooseDateOrTime,
      required this.onpressed});
  String iconImage;
  String textDateOrTime;
  String chooseDateOrTime;
  void Function() onpressed;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Image.asset(iconImage),
        SizedBox(
          width: size.width * .02,
        ),
        Text(
          textDateOrTime,
          style: AppStyle.black16meduim,
        ),
        const Spacer(),
        CustomTextButtom(
          onpressed: onpressed,
          text: chooseDateOrTime,
        )
      ],
    );
  }
}
