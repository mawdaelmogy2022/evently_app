import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/ui/home/taps/home_tap/event_widget.dart';
import 'package:evently_app/ui/home/taps/home_tap/tap_event/event_tap_item.dart';
import 'package:evently_app/utils/app_color.dart';
import 'package:evently_app/utils/app_image.dart';
import 'package:evently_app/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomeTap extends StatefulWidget {
  HomeTap({super.key});

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  @override
  Widget build(BuildContext context) {
    var eventListProvider = Provider.of<EventListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    eventListProvider.getEventNameList(context);
    if (eventListProvider.eventsList.isEmpty) {
      eventListProvider.getAllEvents(userProvider.currentUser!.id);
    }

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.welcome_back,
                  style: AppStyle.white14regular,
                ),
                Text(
                  userProvider.currentUser!.name,
                  style: AppStyle.white24bold,
                )
              ],
            ),
            const Spacer(),
            Image.asset(AppImage.lightImage),
            SizedBox(
              width: size.width * .02,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * .03, vertical: size.height * .015),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColor.whiteColor),
              child: Text(
                'En',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            )
          ],
        ),
        bottom: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16))),
          toolbarHeight: size.height * .15,
          backgroundColor: Theme.of(context).primaryColor,
          title: Column(
            children: [
              Row(
                children: [
                  Image.asset(AppImage.mapIconImage),
                  SizedBox(
                    width: size.width * .02,
                  ),
                  Text(
                    'Cairo , Egypt',
                    style: AppStyle.white14meduim,
                  )
                ],
              ),
              SizedBox(
                height: size.height * .02,
              ),
              DefaultTabController(
                  length: eventListProvider.eventsNameList.length,
                  child: TabBar(
                      isScrollable: true,
                      onTap: (index) {
                        eventListProvider.changeSelectedIndex(
                            index, userProvider.currentUser!.id);
                      },
                      tabAlignment: TabAlignment.start,
                      labelPadding: EdgeInsets.zero,
                      indicatorColor: AppColor.transparentColor,
                      dividerColor: AppColor.transparentColor,
                      tabs: eventListProvider.eventsNameList
                          .map((eventname) => EventTapItem(
                              selectedtextstyle:
                                  Theme.of(context).textTheme.titleMedium!,
                              unselectedtextstyle: AppStyle.white16meduim,
                              eventName: eventname,
                              isselected: eventListProvider.selectedindex ==
                                  eventListProvider.eventsNameList
                                      .indexOf(eventname)))
                          .toList())),
            ],
          ),
        ),
      ),
      body: eventListProvider.filterEventsList.isEmpty
          ? Center(
              child: Text(
              "No Events Found ",
              style: AppStyle.black20bold,
            ))
          : ListView.separated(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * .03, vertical: size.height * .03),
              itemBuilder: (context, index) {
                return EventWidget(
                  event: eventListProvider.filterEventsList[index],
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: size.height * .03,
                );
              },
              itemCount: eventListProvider.filterEventsList.length),
    );
  }
}
