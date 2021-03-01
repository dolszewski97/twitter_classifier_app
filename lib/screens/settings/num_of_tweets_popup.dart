import "package:flutter/material.dart";
import '../../constraints.dart';

class ChangeNoTPopup extends StatefulWidget {
  @override
  _ChangeNoTState createState() => _ChangeNoTState();
}

class _ChangeNoTState extends State<ChangeNoTPopup> {
  //Build method for num of tweets selection pop-up
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
          height: 150,
          margin: EdgeInsets.all(15),
          child: ListView(
            children: <Widget>[
              RichText(
                text: TextSpan(
                    style: Theme.of(context).textTheme.bodyText2,
                    children: [
                      TextSpan(
                          text:
                              "Set number of tweets that You want to download.")
                    ]),
              ),

              SizedBox(height: 30),

              //Num of tweets slider
              Slider.adaptive(
                  value: Constraints.numOfTweets.toDouble(),
                  min: 1,
                  max: 200,
                  divisions: 8,
                  label: Constraints.numOfTweets.toString(),
                  onChanged: (double value) {
                    setState(() {
                      Constraints.numOfTweets = value.toInt();
                    });
                  })
            ],
          )),
    );
  }
}
