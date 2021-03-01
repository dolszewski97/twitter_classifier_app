import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:twitter_classifier_app/screens/analise_user/analise_user_screen.dart';
import 'package:twitter_classifier_app/screens/my_user/my_user_home_screen.dart';
import 'package:twitter_classifier_app/screens/settings/settings_screen.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  static final controller = ScrollController();
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentScreen = 0;

  final widgets = [
    MyUserHomeScreen(),
    AnaliseUserScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  //Build method for both screens - MyHomePage and AnaliseUser
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: currentScreen == 1
          ? isDark
              ? Theme.of(context).primaryColor
              : Color(0xFF1ca1f2)
          : Theme.of(context).primaryColor,
      appBar: currentScreen == 0 ? null : buildAppBar(),
      body: widgets[currentScreen],
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  //Build method for app's appBar (only for Check User screens)
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => SettingsScreen())),
        ),
      ],
    );
  }

  //Build method for bottom nav bar (switch between screens)
  buildBottomNavigationBar() {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return BottomNavigationBar(
        currentIndex: currentScreen,
        backgroundColor:
            isDark ? Theme.of(context).backgroundColor : Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        selectedFontSize: 14,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Check user',
          ),
        ],
        onTap: (index) {
          if (currentScreen == index) {
            MyHomePage.controller.animateTo(0,
                duration: Duration(seconds: 2), curve: Curves.fastOutSlowIn);
          }
          setState(() {
            currentScreen = index;
          });
        });
  }
}
