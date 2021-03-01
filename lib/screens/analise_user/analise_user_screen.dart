import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:twitter_classifier_app/screens/analise_user/show_tweets.dart';

class AnaliseUserScreen extends StatefulWidget {
  _AnaliseUserScreenState createState() => _AnaliseUserScreenState();
}

class _AnaliseUserScreenState extends State<AnaliseUserScreen> {
  final _myTextController = TextEditingController();
  Alignment childAlignment = Alignment.center;
  double sizedBoxTopPaddingDivider = 4;
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    KeyboardVisibilityNotification().addNewListener(onChange: (bool visible) {
      setState(() {
        childAlignment = visible ? Alignment.topCenter : Alignment.center;
        sizedBoxTopPaddingDivider = visible ? 8 : 4;
      });
    });
  }

  @override
  void dispose() {
    _myTextController.dispose();
    super.dispose();
  }

  //Build method for custom user's analise (Check User screen)
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:
          isDark ? Theme.of(context).primaryColor : Color(0xFF1ca1f2),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //First element - Twitter logo with labels
            SizedBox(height: size.height * 0.05),
            Container(
              child: Image.asset(isDark
                  ? 'assets/images/twitter_blue_transparent.png'
                  : 'assets/images/twitter_blue.png'),
              height: 100,
              width: 100,
            ),
            SizedBox(height: 75),
            Text("Classify tweets of any user",
                style: Theme.of(context).textTheme.headline1),
            SizedBox(height: 150),
            Text("Just enter Twitter username",
                style: Theme.of(context).textTheme.headline2),

            //White space with text input and FAB
            SizedBox(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(top: size.height * 0.02),
                        padding: EdgeInsets.only(
                          top: 35,
                          left: 50,
                          right: 50,
                        ),
                        height: size.height * 0.256,
                        decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60),
                            )),
                        child: Container(
                            child: TextField(
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: isDark ? Colors.white : Colors.blue,
                            )),
                            hintText: "type your username",
                            hintStyle: TextStyle(
                                color: isDark ? Colors.white : Colors.blue,
                                fontSize: 12),
                            fillColor: Colors.black,
                          ),
                          controller: _textController,
                        ))),
                  ]),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => onFabPressed(),
        label: Text(
          "Analise",
          style: TextStyle(color: Colors.white),
        ),
        heroTag: _textController.text,
        backgroundColor: isDark ? Colors.black : Color(0xFF1ca1f2),
        icon: Icon(Icons.check, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  //Error dialog when user isn't exists
  showUserNotFoundDialog(String username) {
    return showDialog(
        context: context,
        child: AlertDialog(
          title: Text("User not found."),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('User ' + username + ' does not exist.'),
                Text('Please correct and try again.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }

  /*
    Method that performs actions while FAB is pressed
    * checks, if username is correct
    * checks, if user exists
    * load ShowTweets screen
  */
  onFabPressed() {
    if (_textController.text.toString().length <= 4 ||
        _textController.text.toString().length >= 15) {
      showBadUsernameDialog(_textController.text);
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ShowTweets(twitterAccount: _textController.text)));
    }
  }

  //Error dialog when username is too short or too long (4 <= username <= 15)
  showBadUsernameDialog(String username) {
    return showDialog(
        context: context,
        child: AlertDialog(
          title: Text("Incorrect username."),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Username ' + username + ' is too short or too long.'),
                Text('Please correct and try again.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}
