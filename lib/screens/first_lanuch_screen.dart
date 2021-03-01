import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:twitter_classifier_app/constraints.dart';

import 'my_home_page.dart';

class FirstLanuchScreen extends StatefulWidget {
  @override
  _FirstLanuchScreenState createState() => _FirstLanuchScreenState();
}

class _FirstLanuchScreenState extends State<FirstLanuchScreen> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  //Build method for screen that shows only on first app lanuch
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF1ca1f2),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: size.height * 0.2),
            Container(
              child: Image.asset('assets/images/twitter_blue.png'),
              height: 100,
              width: 100,
            ),
            SizedBox(height: 20),
            Text("Classify tweets whomever You want...",
                style: Theme.of(context).textTheme.headline2),
            SizedBox(height: 220),
            Text("...just enter your Twitter username",
                style: Theme.of(context).textTheme.headline2),
            SizedBox(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(top: size.height * 0.04),
                        padding: EdgeInsets.only(
                          top: 35,
                          left: 50,
                          right: 50,
                        ),
                        height: size.height * 0.256,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60),
                            )),
                        child: Container(
                            child: TextField(
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.blue,
                            )),
                            hintText: "type your username",
                            hintStyle:
                                TextStyle(color: Colors.blue, fontSize: 12),
                            fillColor: Colors.black,
                          ),
                          controller: _textController,
                        ))),
                  ]),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => onFabPressed(),
          tooltip: 'Increment',
          child: Icon(Icons.check)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, //
    );
  }

  /*
    Method that performs actions while FAB is pressed
    * checks, if username is correct
    * checks, if user exists
    * store username in local constraints & SharedPreferences
    * load MyHomePage screen
  */
  onFabPressed() {
    if (_textController.text.toString().length <= 4 ||
        _textController.text.toString().length >= 15) {
      showBadUsernameDialog(_textController.text);
    } else {
      Constraints.username = _textController.text.toString();
      Constraints.storeAllInSharedPrefs();

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    }
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
