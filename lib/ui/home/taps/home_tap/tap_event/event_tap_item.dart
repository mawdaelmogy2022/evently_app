import 'package:evently_app/utils/app_color.dart';
import 'package:flutter/material.dart';

class EventTapItem extends StatelessWidget {
  EventTapItem({
    super.key,
    required this.eventName,
    required this.isselected,
    this.borderColor,
    this.backbroundColor,
    required this.selectedtextstyle,
    required this.unselectedtextstyle,
  });
  String eventName;
  bool isselected;
  Color? borderColor;
  Color? backbroundColor;
  TextStyle selectedtextstyle;
  TextStyle unselectedtextstyle;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * .01),
      padding: EdgeInsets.symmetric(
          horizontal: size.width * .03, vertical: size.height * .01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(46),
        color: isselected
            ? backbroundColor ?? Theme.of(context).focusColor
            : AppColor.transparentColor,
        border: Border.all(
            color: borderColor ?? Theme.of(context).focusColor, width: 1),
      ),
      child: Text(eventName,
          style: isselected ? selectedtextstyle : unselectedtextstyle),
    );
  }
}
