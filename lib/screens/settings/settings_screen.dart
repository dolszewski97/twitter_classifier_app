import 'package:flutter/material.dart';
import 'package:twitter_classifier_app/screens/settings/settings_screen_body.dart';

class SettingsScreen extends StatefulWidget {
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SettingsScreenBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).backgroundColor,
      elevation: 0,
      title: Text("Settings"),
    );
  }
}
