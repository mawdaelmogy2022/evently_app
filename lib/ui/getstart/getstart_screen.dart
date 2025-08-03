import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/ui/widget/custom_buttom.dart';
import 'package:evently_app/utils/app_color.dart';
import 'package:evently_app/utils/app_image.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class GetstartScreen extends StatelessWidget {
  const GetstartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * .05, vertical: size.height * .03),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AppImage.logonameImage),
              Image.asset(AppImage.getstartImage),
              Text(
                'Personalize Your Experience',
                style: AppStyle.blue20bold,
              ),
              SizedBox(
                height: size.height * .02,
              ),
              Text(
                'Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.',
                style: themeProvider.apptheme == ThemeMode.light
                    ? AppStyle.black16meduim
                    : AppStyle.white16meduim,
              ),
              Row(
                children: [
                  Text(
                    'Language',
                    style: AppStyle.blue20meduim,
                  ),
                  const Spacer(),
                  ToggleSwitch(
                    customWidgets: [
                      Image.asset(AppImage.enImage),
                      Image.asset(AppImage.rgImage)
                    ],
                    initialLabelIndex: 1,
                    cornerRadius: 20.0,
                    inactiveBgColor: themeProvider.apptheme == ThemeMode.light
                        ? AppColor.whiteColor
                        : AppColor.primaryblueblackColor,
                    totalSwitches: 2,
                    activeBgColors: [
                      [
                        themeProvider.apptheme == ThemeMode.light
                            ? AppColor.whiteColor
                            : AppColor.primaryblueblackColor
                      ],
                      [
                        themeProvider.apptheme == ThemeMode.light
                            ? AppColor.whiteColor
                            : AppColor.primaryblueblackColor
                      ],
                    ],
                    onToggle: (index) {
                      if (index == 0) {
                        languageProvider.changeLanguage(newLanguage: 'ar');
                      } else {
                        languageProvider.changeLanguage(newLanguage: 'en');
                      }
                      print('switched to: $index');
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Theme',
                    style: AppStyle.blue20meduim,
                  ),
                  const Spacer(),
                  ToggleSwitch(
                    customWidgets: [
                      Image.asset(
                        AppImage.lightImage,
                        color: AppColor.primaryblueColor,
                      ),
                      Image.asset(AppImage.darkImage)
                    ],
                    initialLabelIndex: 1,
                    cornerRadius: 20.0,
                    inactiveBgColor: themeProvider.apptheme == ThemeMode.light
                        ? AppColor.whiteColor
                        : AppColor.primaryblueblackColor,
                    totalSwitches: 2,
                    activeBgColors: [
                      [
                        themeProvider.apptheme == ThemeMode.light
                            ? AppColor.whiteColor
                            : AppColor.primaryblueblackColor
                      ],
                      [
                        themeProvider.apptheme == ThemeMode.light
                            ? AppColor.whiteColor
                            : AppColor.primaryblueblackColor
                      ],
                    ],
                    onToggle: (index) {
                      if (index == 0) {
                        themeProvider.changeTheme(ThemeMode.light);
                      } else {
                        themeProvider.changeTheme(ThemeMode.dark);
                      }
                      // print('switched to: $index');
                    },
                  ),
                ],
              ),
              SizedBox(
                height: size.height * .02,
              ),
              CustomButtom(
                text: 'Let’s Start',
                onpressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(AppRoutes.onboardingRoute);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
