import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguageProvider extends ChangeNotifier {
  String languagName = 'en';
  AppLanguageProvider() {
    loadSavedLanguage();
  }
  Future<void> loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    languagName = prefs.getString('language') ?? 'en';
    notifyListeners();
  }

  void changeLanguage({required String newLanguage}) async {
    if (newLanguage == languagName) {
      return;
    }
    languagName = newLanguage;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('language', newLanguage);
    notifyListeners();
  }
}
