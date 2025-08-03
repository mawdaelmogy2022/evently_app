import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/firebase_utils.dart';
import 'package:evently_app/model/event_model.dart';
import 'package:evently_app/utils/app_color.dart';
import 'package:evently_app/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventListProvider extends ChangeNotifier {
  List<EventModel> eventsList = [];
  List<EventModel> filterEventsList = [];

  List<String> eventsNameList = [];
  int selectedindex = 0;
  List<EventModel> favouriteEventList = [];
  List<String> getEventNameList(BuildContext context) {
    return eventsNameList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.eating,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.meeting,
    ];
  }

  /// to do : get All event
  void getAllEvents(String uId) async {
    QuerySnapshot<EventModel> querySnapshot =
        await FirebaseUtils.getEventCollection(uId).get();
    eventsList = querySnapshot.docs.map(
      (doc) {
        return doc.data();
      },
    ).toList();
    filterEventsList = eventsList;
    notifyListeners();
  }

  /// to do : get filter event
  void getFilterEvents(String uId) async {
    var querySnapshot = await FirebaseUtils.getEventCollection(uId).get();
    eventsList = querySnapshot.docs.map(
      (doc) {
        return doc.data();
      },
    ).toList();
    filterEventsList = eventsList.where(
      (event) {
        return event.eventname == eventsNameList[selectedindex];
      },
    ).toList();
    notifyListeners();
  }

  void updateIsFavourite(EventModel event, String uId) {
    FirebaseUtils.getEventCollection(uId)
        .doc(event.id)
        .update({"isFavourite": !event.isfavourite}).timeout(
            const Duration(milliseconds: 500), onTimeout: () {
      ToastUtils.toastMes(
          message: 'Event Updated Successfully.',
          backgroundcolor: AppColor.primaryblueColor,
          textcolor: AppColor.whiteColor);
    });
    selectedindex == 0 ? getAllEvents(uId) : getFilterEvents(uId);
    getAllFavouriteEvent(uId);
    notifyListeners();
  }

  void getAllFavouriteEvent(String uId) async {
    var querySnapshot = await FirebaseUtils.getEventCollection(uId).get();
    eventsList = querySnapshot.docs.map(
      (doc) {
        return doc.data();
      },
    ).toList();
    favouriteEventList = eventsList.where(
      (event) {
        return event.isfavourite == true;
      },
    ).toList();
  }

  void changeSelectedIndex(int newselectedIndex, String uId) {
    selectedindex = newselectedIndex;
    selectedindex == 0 ? getAllEvents(uId) : getFilterEvents(uId);
  }
}
