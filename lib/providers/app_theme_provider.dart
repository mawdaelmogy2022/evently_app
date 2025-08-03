import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode apptheme = ThemeMode.light;
  AppThemeProvider() {
    _loadSavedTheme();
  }

  Future<void> _loadSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString('app_theme') ?? 'light';

    if (themeString == 'dark') {
      apptheme = ThemeMode.dark;
    } else {
      apptheme = ThemeMode.light;
    }

    notifyListeners();
  }

  changeTheme(ThemeMode newTheme) async {
    if (apptheme == newTheme) {
      return;
    }
    apptheme = newTheme;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'app_theme', newTheme == ThemeMode.dark ? 'dark' : 'light');

    notifyListeners();
  }
}
