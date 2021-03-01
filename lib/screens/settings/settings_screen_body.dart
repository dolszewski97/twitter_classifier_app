import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_classifier_app/constraints.dart';
import 'package:twitter_classifier_app/theme/theme_changer.dart';
import 'num_of_tweets_popup.dart';

class SettingsScreenBody extends StatefulWidget {
  @override
  _SettingsScreenBodyState createState() => _SettingsScreenBodyState();
}

class _SettingsScreenBodyState extends State<SettingsScreenBody> {
  double accuracy = 0.0;

  @override
  void initState() {
    super.initState();
    //Fetch to server for accuracy stats
  }

  @override
  void dispose() {
    Constraints.storeAllInSharedPrefs();
    super.dispose();
  }

  //Build method for SettingsScreen body
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Theme settings - dark theme toogle with notify to app's notifier
              Text("Theme settings",
                  style: Theme.of(context).textTheme.headline5),
              Consumer<ThemeChanger>(
                builder: (context, notifier, child) => SwitchListTile(
                  onChanged: (bool value) => notifier.toggleTheme(),
                  title: Text("Dark theme"),
                  value: notifier.getDarkTheme(),
                  subtitle: Text(notifier.getDarkTheme()
                      ? "Dark theme is enable"
                      : "Dark theme is disable"),
                ),
              ),

              Divider(height: 40, color: Theme.of(context).accentColor),

              //Classifier settings - classifier select, accuracy toogle and num of tweets slider
              Text("Classifier settings",
                  style: Theme.of(context).textTheme.headline5),
              Text("Curently downloaded tweets won't be modified.",
                  style: Theme.of(context).textTheme.bodyText2),
              Container(
                  child: SwitchListTile(
                title: Text("Naive Bayes Classifier"),
                subtitle: Text(Constraints.isBayesSelected
                    ? "Naive Bayes is selected"
                    : "Naive Bayes isn't selected"),
                onChanged: (bool value) {
                  Constraints.isBayesSelected = value;
                  accuracy = 0.0;
                  setState(() {
                    Constraints.storeAllInSharedPrefs();
                  });
                },
                value: Constraints.isBayesSelected,
              )),
              Container(
                  child: SwitchListTile(
                title: Text("VADER Classifier"),
                subtitle: Text(!Constraints.isBayesSelected
                    ? "VADER classifier is selected"
                    : "VADER classifier isn't selected"),
                onChanged: (bool value) {
                  Constraints.isBayesSelected = !value;
                  accuracy = 0.0;
                  setState(() {
                    Constraints.storeAllInSharedPrefs();
                  });
                },
                value: !Constraints.isBayesSelected,
              )),
              Container(
                  child: ListTile(
                      title: Text("Current classifier accurancy"),
                      subtitle: accuracy == 0.0
                          ? Text('Tap for details...')
                          : Text(Constraints.isBayesSelected
                              ? "Bayes classifier accuracy: " +
                                  accuracy.toStringAsPrecision(4) +
                                  '%'
                              : "VADER classifier accuracy: " +
                                  accuracy.toStringAsPrecision(4) +
                                  '%'),
                      onTap: () {
                        setState(() {
                          accuracy = Constraints.isBayesSelected
                              ? Constraints.lastBayesAccuracy
                              : Constraints.lastVaderAccuracy;
                        });
                      })),
              Container(
                  child: ListTile(
                title: Text("Number of tweets to download"),
                subtitle: Text("Tap to change. Current: " +
                    Constraints.numOfTweets.toString()),
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) => ChangeNoTPopup(),
                  ).then((value) => setState(() {}));
                },
              ))
            ]),
      ),
    );
  }
}
