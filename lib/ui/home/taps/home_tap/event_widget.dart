import 'package:evently_app/model/event_model.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/utils/app_color.dart';
import 'package:evently_app/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventWidget extends StatelessWidget {
  EventWidget({super.key, required this.event});
  EventModel event;

  @override
  Widget build(BuildContext context) {
    var eventListProvider = Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * .3,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(
              event.image,
            ),
            fit: BoxFit.fill,
          ),
          border: Border.all(color: AppColor.primaryblueColor, width: 2)),
      child: Padding(
        padding: EdgeInsets.all(size.width * .03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * .03, vertical: size.height * .005),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).cardColor),
              child: Column(
                children: [
                  Text(
                    event.dateTime.day.toString(),
                    style: AppStyle.blue20bold,
                  ),
                  Text(
                    DateFormat('MMM').format(event.dateTime),
                    //  event.dateTime.month.toString(),
                    style: AppStyle.blue14bold,
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: size.width * .02),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).cardColor),
              child: Row(
                children: [
                  Text(
                    event.description,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        eventListProvider.updateIsFavourite(
                            event, userProvider.currentUser!.id);
                      },
                      icon: event.isfavourite == true
                          ? const Icon(
                              Icons.favorite,
                              color: AppColor.primaryblueColor,
                            )
                          : const Icon(
                              Icons.favorite_outline_outlined,
                              color: AppColor.primaryblueColor,
                            ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
