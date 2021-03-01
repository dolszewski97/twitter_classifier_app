import 'package:flutter/material.dart';
import 'package:twitter_classifier_app/screens/settings/settings_screen.dart';
import 'package:twitter_classifier_app/screens/analise_user/show_tweets_body.dart';

class ShowTweets extends StatelessWidget {
  final String twitterAccount;

  const ShowTweets({Key key, this.twitterAccount}) : super(key: key);

  //Build method for custom user tweets analise screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: buildAppBar(context),
      body: ShowTweetsBody(twitterAccount: twitterAccount),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.settings),
          color: Colors.white,
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => SettingsScreen())),
        ),
      ],
    );
  }
}
