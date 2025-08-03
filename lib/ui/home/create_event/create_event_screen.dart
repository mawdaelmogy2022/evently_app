import 'package:evently_app/firebase_utils.dart';
import 'package:evently_app/model/event_model.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/ui/home/create_event/widget/date_or_time_widget.dart';
import 'package:evently_app/ui/home/taps/home_tap/tap_event/event_tap_item.dart';
import 'package:evently_app/ui/widget/custom_buttom.dart';
import 'package:evently_app/ui/widget/custom_text_form_field.dart';
import 'package:evently_app/utils/app_color.dart';
import 'package:evently_app/utils/app_image.dart';
import 'package:evently_app/utils/app_style.dart';
import 'package:evently_app/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  int selectedIndex = 0;
  DateTime? selectdate;
  String formattedDate = '';
  TimeOfDay? selectedtime;
  String formattedTime = '';
  @override
  Widget build(BuildContext context) {
    List<String> eventsNameList = [
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
    List<String> eventimages = [
      AppImage.sportImage,
      AppImage.birthdayImage,
      AppImage.bookclubImage,
      AppImage.eatingImage,
      AppImage.gamingImage,
      AppImage.holidayImage,
      AppImage.exhibitionImage,
      AppImage.workshopImage,
      AppImage.meetingImage,
    ];
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    var eventListRrovider = Provider.of<EventListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        iconTheme: const IconThemeData(color: AppColor.primaryblueColor),
        title: Text(
          'Create Event',
          style: AppStyle.blue20meduim,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * .04, vertical: size.height * .02),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(eventimages[selectedIndex]),
              ),
              SizedBox(height: size.height * .02),
              SizedBox(
                height: size.height * .06,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          selectedIndex = index;
                          setState(() {});
                        },
                        child: EventTapItem(
                            selectedtextstyle: AppStyle.white16meduim,
                            unselectedtextstyle:
                                Theme.of(context).textTheme.titleMedium!,
                            borderColor: AppColor.primaryblueColor,
                            backbroundColor: AppColor.primaryblueColor,
                            eventName: eventsNameList[index],
                            isselected: selectedIndex == index),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: size.width * .01);
                    },
                    itemCount: eventsNameList.length),
              ),
              SizedBox(height: size.height * .02),
              Text(
                AppLocalizations.of(context)!.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: size.height * .01),
              CustomTextFormField(
                  prefixIcon: Image.asset(AppImage.editIconImage),
                  hintText: AppLocalizations.of(context)!.event_title,
                  textEditingController: titleController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'please enter event title';
                    }
                    return null;
                  }),
              SizedBox(height: size.height * .01),
              Text(
                AppLocalizations.of(context)!.description,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: size.height * .01),
              CustomTextFormField(
                  maxlines: 4,
                  hintText: AppLocalizations.of(context)!.event_description,
                  textEditingController: descriptionController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'please enter event description';
                    }
                    return null;
                  }),
              SizedBox(height: size.height * .02),
              DateOrTimeWidget(
                  onpressed: choosedate,
                  iconImage: AppImage.dateIconImage,
                  textDateOrTime: 'Event Date',
                  chooseDateOrTime:
                      selectdate == null ? 'Choose Date' : formattedDate
                  //  '${selectdate!.day}/${selectdate!.month}/${selectdate!.year}'
                  ),
              DateOrTimeWidget(
                  onpressed: choosetime,
                  iconImage: AppImage.timeIconImage,
                  textDateOrTime: 'Event Time',
                  chooseDateOrTime:
                      selectedtime == null ? 'Choose Time' : formattedTime
                  // '${selectedtime!.hour} : ${selectedtime!.minute}'
                  ),
              SizedBox(height: size.height * .02),
              CustomButtom(
                text: AppLocalizations.of(context)!.add_event,
                onpressed: () {
                  EventModel event = EventModel(
                      dateTime: selectdate!,
                      time: formattedTime,
                      title: titleController.text,
                      description: descriptionController.text,
                      image: eventimages[selectedIndex],
                      eventname: eventsNameList[selectedIndex]);
                  var userProvider =
                      Provider.of<UserProvider>(context, listen: false);
                  FirebaseUtils.addEventToFireStore(
                          event, userProvider.currentUser!.id)
                      .then(
                    (value) {
                      ToastUtils.toastMes(
                          message: 'Event added succfully',
                          backgroundcolor: AppColor.primaryblueColor,
                          textcolor: AppColor.whiteColor);
                      print('Event added successfully');
                      eventListRrovider
                          .getAllEvents(userProvider.currentUser!.id);
                    },
                  ).timeout(
                    const Duration(milliseconds: 500),
                    onTimeout: () {
                      ToastUtils.toastMes(
                          message: 'Event added succfully',
                          backgroundcolor: AppColor.primaryblueColor,
                          textcolor: AppColor.whiteColor);
                      print('Event added successfully');
                      eventListRrovider
                          .getAllEvents(userProvider.currentUser!.id);
                      Navigator.pop(context);
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void choosedate() async {
    var choosedate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    selectdate = choosedate;
    formattedDate = DateFormat('dd/MM/yyyy').format(selectdate!);
    setState(() {});
  }

  void choosetime() async {
    var choosetime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    selectedtime = choosetime;
    formattedTime = selectedtime!.format(context);
    setState(() {});
  }
}
