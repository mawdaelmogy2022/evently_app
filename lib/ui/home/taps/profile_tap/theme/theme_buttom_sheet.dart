import 'package:evently_app/providers/app_theme_provider.dart';
import 'package:evently_app/utils/app_color.dart';
import 'package:evently_app/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ThemeButtomSheet extends StatefulWidget {
  const ThemeButtomSheet({super.key});

  @override
  State<ThemeButtomSheet> createState() => _ThemeButtomSheet();
}

class _ThemeButtomSheet extends State<ThemeButtomSheet> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * .05, vertical: size.height * .05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: () {
                  themeProvider.changeTheme(ThemeMode.dark);
                },
                child: themeProvider.apptheme == ThemeMode.dark
                    ? getSelectedthemeItem(
                        themeName: AppLocalizations.of(context)!.dark)
                    : getUnSelectedthemeItem(
                        themename: AppLocalizations.of(context)!.dark)),
            SizedBox(
              height: size.height * .01,
            ),
            InkWell(
                onTap: () {
                  themeProvider.changeTheme(ThemeMode.light);
                },
                child: themeProvider.apptheme == ThemeMode.light
                    ? getSelectedthemeItem(
                        themeName: AppLocalizations.of(context)!.light)
                    : getUnSelectedthemeItem(
                        themename: AppLocalizations.of(context)!.light)),
          ],
        ),
      ),
    );
  }

  Widget getSelectedthemeItem({required String themeName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          themeName,
          style: AppStyle.blue20bold,
        ),
        const Icon(
          Icons.check,
          size: 28,
          color: AppColor.primaryblueColor,
        ),
      ],
    );
  }

  Widget getUnSelectedthemeItem({required String themename}) {
    return Text(
      themename,
      style: AppStyle.black20bold,
    );
  }
}
