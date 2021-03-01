import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
  Notifier class that changes entire app's theme.
*/
class ThemeChanger with ChangeNotifier {
  final String themeKey = "theme";
  SharedPreferences preferences;
  bool _darkTheme = false;

  ThemeChanger() {
    _loadFromPreferences();
  }

  bool getDarkTheme() => _darkTheme;

  //Method that toggles theme and notifies the app's listener
  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPreferences();
    notifyListeners();
  }

  _initPreferences() async {
    if (preferences == null) {
      preferences = await SharedPreferences.getInstance();
    }
  }

  _loadFromPreferences() async {
    await _initPreferences();
    _darkTheme = preferences.getBool(themeKey) ?? false;
    notifyListeners();
  }

  _saveToPreferences() async {
    await _initPreferences();
    await preferences.setBool(themeKey, _darkTheme);
  }
}
