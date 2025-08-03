import 'package:evently_app/ui/home/taps/home_tap/home_tap.dart';
import 'package:evently_app/ui/home/taps/love_tap/love_tap.dart';
import 'package:evently_app/ui/home/taps/map_tap/map_tap.dart';
import 'package:evently_app/ui/home/taps/profile_tap/profile_tap.dart';
import 'package:evently_app/utils/app_color.dart';
import 'package:evently_app/utils/app_image.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> taps = [
    HomeTap(),
    MapTap(),
    LoveTap(),
    ProfileTap(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: taps[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          type: BottomNavigationBarType.fixed,
          items: [
            buildButtomNavigationBarItem(
                index: 0,
                iconselectedName: AppImage.homeSelectedIconImage,
                iconName: AppImage.homeIconImage,
                label: AppLocalizations.of(context)!.home),
            buildButtomNavigationBarItem(
                index: 1,
                iconselectedName: AppImage.mapSelectedIconImage,
                iconName: AppImage.mapIconImage,
                label: AppLocalizations.of(context)!.map),
            buildButtomNavigationBarItem(
                iconselectedName: AppImage.loveSelectedIconImage,
                index: 2,
                iconName: AppImage.loveIconImage,
                label: AppLocalizations.of(context)!.love),
            buildButtomNavigationBarItem(
                index: 3,
                iconselectedName: AppImage.profileSelectedIconImage,
                iconName: AppImage.profileIconImage,
                label: AppLocalizations.of(context)!.profile),
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // to do : navigation to create event screen
          Navigator.of(context).pushNamed(AppRoutes.createeventRoute);
        },
        child: const Icon(
          Icons.add,
          size: 32,
          color: AppColor.whiteColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  BottomNavigationBarItem buildButtomNavigationBarItem(
      {required String iconName,
      required String iconselectedName,
      required String label,
      required int index}) {
    return BottomNavigationBarItem(
        icon: ImageIcon(
          AssetImage(index == selectedIndex ? iconselectedName : iconName),
        ),
        label: label);
  }
}
/*
*/
