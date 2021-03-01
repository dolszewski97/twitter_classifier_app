import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
  Class with constraints accessable from every class/file.
  Also performs operations on SharedPreferences. 
*/
class Constraints with ChangeNotifier {
  static const String numOfTweetsKey = "nOT";
  static const String numOfTweetsHomeKey = "nOTH";
  static const String usernameKey = "username";
  static const String lastBayesAccuracyKey = "lastBayesAcc";
  static const String lastVaderAccuracyKey = "lastVaderAcc";
  static const String darkModeKey = "darkMode";
  static const String systemThemeKey = "systemTheme";
  static const String isBayesSelectedKey = "isBayesSelected";
  static const String isDatabaseEmptyKey = "isDatabaseEmpty";

  static SharedPreferences _preferences;
  static int numOfTweets;
  static int numOfTweetsHome;
  static String username;
  static double lastBayesAccuracy;
  static double lastVaderAccuracy;
  static bool darkMode;
  static bool systemTheme;
  //If isBayesSelected = false, then VADER is selected
  static bool isBayesSelected;
  static bool isDatabaseEmpty;

  static _getInstance() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static initSharedPreferences() async {
    await _getInstance();
    loadDataFromShared();
  }

  // ignore: unused_element
  static _printLocalVariables() {
    String message = numOfTweets.toString() +
        " " +
        username +
        " " +
        lastVaderAccuracy.toString() +
        " " +
        darkMode.toString() +
        " " +
        isDatabaseEmpty.toString();
    print("Some local variables:");
    print(message);
  }

  //Load user settings from SharedPreferences (or set default values)
  static loadDataFromShared() {
    numOfTweets = _preferences.getInt(numOfTweetsKey) ?? 100;
    numOfTweetsHome = _preferences.getInt(numOfTweetsHomeKey) ?? 100;
    username = _preferences.getString(usernameKey) ?? "";
    lastBayesAccuracy = _preferences.getDouble(lastBayesAccuracyKey) ?? 74.0;
    lastVaderAccuracy = _preferences.getDouble(lastVaderAccuracyKey) ?? 83.0;
    darkMode = _preferences.getBool(darkModeKey) ?? false;
    systemTheme = _preferences.getBool(systemThemeKey) ?? false;
    isBayesSelected = _preferences.getBool(isBayesSelectedKey) ?? true;
    isDatabaseEmpty = _preferences.getBool(isDatabaseEmptyKey) ?? true;
  }

  //Set new value/Change value in SharedPreferences
  static setNewValue(String key, var value) {
    switch (value.runtimeType) {
      case int:
        _preferences.setInt(key, value);
        break;
      case String:
        _preferences.setString(key, value);
        break;
      case bool:
        _preferences.setBool(key, value);
        break;
    }
  }

  //Save all constraints to SharedPreferences
  static storeAllInSharedPrefs() {
    _preferences.setInt(numOfTweetsKey, numOfTweets);
    _preferences.setInt(numOfTweetsHomeKey, numOfTweetsHome);
    _preferences.setString(usernameKey, username);
    _preferences.setDouble(lastBayesAccuracyKey, lastBayesAccuracy);
    _preferences.setDouble(lastVaderAccuracyKey, lastVaderAccuracy);
    _preferences.setBool(isBayesSelectedKey, isBayesSelected);
    _preferences.setBool(darkModeKey, darkMode);
    _preferences.setBool(systemThemeKey, systemTheme);
    _preferences.setBool(isDatabaseEmptyKey, isDatabaseEmpty);
  }
}
