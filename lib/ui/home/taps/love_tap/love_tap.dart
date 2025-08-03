import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/ui/home/taps/home_tap/event_widget.dart';
import 'package:evently_app/ui/widget/custom_text_form_field.dart';
import 'package:evently_app/utils/app_color.dart';
import 'package:evently_app/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LoveTap extends StatefulWidget {
  LoveTap({super.key});

  @override
  State<LoveTap> createState() => _LoveTapState();
}

class _LoveTapState extends State<LoveTap> {
  TextEditingController searchController = TextEditingController();
  late EventListProvider eventListProvider;
  late UserProvider userProvider;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        eventListProvider.getAllFavouriteEvent(userProvider.currentUser!.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    eventListProvider = Provider.of<EventListProvider>(context);
    userProvider = Provider.of<UserProvider>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: size.width * .03,
                right: size.width * .03,
                top: size.height * .03),
            child: CustomTextFormField(
              validator: (p0) {},
              textEditingController: searchController,
              prefixIcon: const Icon(Icons.search_outlined),
              prefixIconColor: AppColor.primaryblueColor,
              hintText: AppLocalizations.of(context)!.search_for_event,
              hintTextstyle: AppStyle.blue14bold,
              borderColor: AppColor.primaryblueColor,
            ),
          ),
          Expanded(
            child: eventListProvider.favouriteEventList.isEmpty
                ? Center(
                    child: Text(
                      'No Favourite Event Founded',
                      style: AppStyle.black20bold,
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * .03,
                        vertical: size.height * .03),
                    itemBuilder: (context, index) {
                      return EventWidget(
                          event: eventListProvider.favouriteEventList[index]);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: size.height * .03,
                      );
                    },
                    itemCount: eventListProvider.favouriteEventList.length),
          )
        ],
      )),
    );
  }
}
