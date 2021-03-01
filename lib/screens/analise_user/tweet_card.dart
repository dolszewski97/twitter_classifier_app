import 'package:flutter/material.dart';
import 'package:twitter_classifier_app/datatypes/tweet.dart';

class TweetCard extends StatelessWidget {
  final Tweet _tweet;

  TweetCard(this._tweet);

  //Build method for tweet cards
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: <Widget>[
            //Forst row - show tweet's author, author's username and Twitter logo
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Text(
                              _tweet.tweetAuthorName,
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            Text(
                              _tweet.tweetAuthorNickname,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ],
                        )
                      ]),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(Theme.of(context).brightness == Brightness.dark
                        ? 'assets/images/twitter_black.png'
                        : 'assets/images/twitter.png'),
                  ],
                ),
              ],
            ),

            SizedBox(height: 15),

            //Show tweet's body and analise results
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                      style: Theme.of(context).textTheme.bodyText1,
                      children: [
                        TextSpan(
                          text: _tweet.tweetBody,
                        )
                      ]),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Pos: " +
                                double.parse(_tweet.posProb.toStringAsFixed(2))
                                    .toString(),
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          Text(
                            "\t\tNeg: " +
                                double.parse(_tweet.negProb.toStringAsFixed(2))
                                    .toString(),
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          Text(
                            _tweet.cv <= 1.0
                                ? "\t\tNeu: " +
                                    double.parse(
                                            _tweet.neuProb.toStringAsFixed(2))
                                        .toString()
                                : "",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          Text(
                            _tweet.cv <= 1.0
                                ? "\t\tCV: " +
                                    double.parse(_tweet.cv.toStringAsFixed(2))
                                        .toString()
                                : "",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Result: " + _tweet.result,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
