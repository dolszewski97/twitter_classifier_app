import 'dart:ui';

import 'package:flutter/material.dart';

/*
  Custom theme settings.
*/

//Light theme
ThemeData light = ThemeData(
    brightness: Brightness.light,
    backgroundColor: Colors.white,
    primaryColor: Colors.lightBlue,
    accentColor: Colors.blueAccent,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    buttonColor: Colors.blueAccent,
    textTheme: TextTheme(
        headline1: TextStyle(
            color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold),
        headline2: TextStyle(
            color: Colors.white70, fontSize: 18, fontWeight: FontWeight.bold),
        button: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        //Tweet's author
        headline3: TextStyle(
            color: Color(0xFF535353),
            fontSize: 15,
            fontWeight: FontWeight.bold),
        //Tweet's nickname
        headline4: TextStyle(
            color: Color(0xFF535353),
            fontSize: 15,
            fontStyle: FontStyle.italic),
        //Settings group title
        headline5: TextStyle(
          color: Colors.black,
          fontSize: 24,
        ),
        //Tweet's body text
        bodyText1: TextStyle(color: Colors.black87, fontSize: 14),
        //Tweet's predictions
        bodyText2: TextStyle(color: Colors.black54)));

//Dark theme
ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: Color(0xFF2E2E2E),
    primaryColor: Colors.black,
    accentColor: Colors.grey,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    buttonColor: Colors.grey,
    textTheme: TextTheme(
        headline1: TextStyle(
            color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold),
        headline2: TextStyle(
            color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),
        button: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        //Tweet's author
        headline3: TextStyle(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        //Tweet's nickname
        headline4: TextStyle(
            color: Colors.white54, fontSize: 15, fontStyle: FontStyle.italic),
        //Settings group title
        headline5: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
        //Tweet's body text
        bodyText1: TextStyle(color: Colors.white, fontSize: 14),
        //Tweet's predictions
        bodyText2: TextStyle(color: Colors.white54)));
