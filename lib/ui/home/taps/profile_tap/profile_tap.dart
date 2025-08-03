import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/ui/home/taps/profile_tap/language/language_buttom_sheet.dart';
import 'package:evently_app/ui/home/taps/profile_tap/theme/theme_buttom_sheet.dart';
import 'package:evently_app/ui/widget/custom_buttom.dart';
import 'package:evently_app/utils/app_color.dart';
import 'package:evently_app/utils/app_image.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ProfileTap extends StatefulWidget {
  const ProfileTap({super.key});

  @override
  State<ProfileTap> createState() => _ProfileTapState();
}

class _ProfileTapState extends State<ProfileTap> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    var eventListProvider = Provider.of<EventListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryblueColor,
        toolbarHeight: size.height * .2,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40))),
        title: Row(
          children: [
            Image.asset(AppImage.routeImage),
            SizedBox(
              width: size.width * .03,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userProvider.currentUser!.name,
                    style: AppStyle.white24bold,
                  ),
                  Text(
                    userProvider.currentUser!.email,
                    overflow: TextOverflow.visible,
                    style: AppStyle.white16meduim,
                  )
                ],
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * .04, vertical: size.height * .04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.language,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: size.height * .02),
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * .05, vertical: size.height * .02),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColor.primaryblueColor)),
              child: GestureDetector(
                onTap: () {
                  showLanguageButtonSheet();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      languageProvider.languagName == 'en'
                          ? AppLocalizations.of(context)!.english
                          : AppLocalizations.of(context)!.arabic,
                      style: AppStyle.blue20bold,
                    ),
                    const Icon(
                      Icons.arrow_drop_down_outlined,
                      size: 28,
                      color: AppColor.primaryblueColor,
                    ),
                  ],
                ),
              ),
            ),
            Text(
              AppLocalizations.of(context)!.theme,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: size.height * .02),
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * .05, vertical: size.height * .02),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColor.primaryblueColor)),
              child: GestureDetector(
                onTap: () {
                  showThemButtonSheet();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      themeProvider.apptheme == ThemeMode.dark
                          ? AppLocalizations.of(context)!.dark
                          : AppLocalizations.of(context)!.light,
                      style: AppStyle.blue20bold,
                    ),
                    const Icon(
                      Icons.arrow_drop_down_outlined,
                      size: 28,
                      color: AppColor.primaryblueColor,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            CustomButtom(
                mainAxisAlignment: MainAxisAlignment.start,
                backgroundColor: AppColor.redColor,
                imageIcon: true,
                imageIconUrl: AppImage.logoutIconImage,
                text: AppLocalizations.of(context)!.logout,
                colorborder: AppColor.redColor,
                onpressed: () {
                  // eventListProvider.favouriteEventList = [];
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.loginRoute,
                    (route) => false,
                  );
                })
          ],
        ),
      ),
    );
  }

  void showLanguageButtonSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => LanguageButtomSheet());
  }

  void showThemButtonSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => ThemeButtomSheet());
  }
}


/*
  ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    backgroundColor: AppColor.redColor,
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * .05,
                        vertical: size.height * .02)),
                onPressed: () {},
                child: Row(
                  children: [
                    const Icon(
                      Icons.logout_outlined,
                      color: AppColor.whiteColor,
                    ),
                    SizedBox(
                      width: size.width * .01,
                    ),
                    Text(
                      AppLocalizations.of(context)!.logout,
                      style: AppStyle.white20regular,
                    )
                  ],
                ))
                */