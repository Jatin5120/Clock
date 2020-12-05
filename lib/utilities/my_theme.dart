import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyTheme extends ChangeNotifier {

  bool isDark = false;
  ThemeMode currentThemeMode = ThemeMode.light;
  static SharedPreferences prefs;

  setPreference() async {
    print("Before $isDark");
    prefs = await SharedPreferences.getInstance();
    print("Set Preferences\nShared Preference Initiated");
    isDark = prefs.getBool('isDark') ?? false;
    print('isDark: $isDark');
    currentThemeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  ThemeMode get getCurrentThemeMode => currentThemeMode;

  changeTheme() async {
    isDark = !isDark;
    currentThemeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    prefs = await SharedPreferences.getInstance();
    print("Change Theme\nShared Preference Initiated");
    prefs.setBool('isDark', isDark);
    print('isDark: $isDark');
    notifyListeners();
  }

}