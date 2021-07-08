import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_classifier_app/constraints.dart';
import 'package:twitter_classifier_app/screens/first_lanuch_screen.dart';
import 'package:twitter_classifier_app/screens/my_home_page.dart';
import 'package:twitter_classifier_app/theme/theme.dart';
import 'package:twitter_classifier_app/theme/theme_changer.dart';

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Load user settings from SharedPreferences
  await Constraints.initSharedPreferences();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeChanger(),
      child: Consumer<ThemeChanger>(builder: (context, notifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Twitter Classifier App',
          theme: notifier.getDarkTheme() ? dark : light,
          home: Constraints.username != ""
              ? MyHomePage(title: 'Twitter Classifier App Home Page')
              : FirstLanuchScreen(),
        );
      }),
    );
  }
}
