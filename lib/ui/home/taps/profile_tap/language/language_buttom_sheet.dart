import 'package:evently_app/providers/app_language_provider.dart';
import 'package:evently_app/utils/app_color.dart';
import 'package:evently_app/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LanguageButtomSheet extends StatefulWidget {
  const LanguageButtomSheet({super.key});

  @override
  State<LanguageButtomSheet> createState() => _LanguageButtomSheetState();
}

class _LanguageButtomSheetState extends State<LanguageButtomSheet> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
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
                languageProvider.changeLanguage(newLanguage: 'en');
              },
              child: languageProvider.languagName == 'en'
                  ? getSelectedLanguageItem(
                      languageName: AppLocalizations.of(context)!.english)
                  : getUnSelectedLanguageItem(
                      languageName: AppLocalizations.of(context)!.english),
            ),
            SizedBox(
              height: size.height * .01,
            ),
            InkWell(
              onTap: () {
                languageProvider.changeLanguage(newLanguage: 'ar');
              },
              child: languageProvider.languagName == 'ar'
                  ? getSelectedLanguageItem(
                      languageName: AppLocalizations.of(context)!.arabic)
                  : getUnSelectedLanguageItem(
                      languageName: AppLocalizations.of(context)!.arabic),
            ),
          ],
        ),
      ),
    );
  }

  Widget getSelectedLanguageItem({required String languageName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          languageName,
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

  Widget getUnSelectedLanguageItem({required String languageName}) {
    return Text(
      languageName,
      style: AppStyle.black20bold,
    );
  }
}
