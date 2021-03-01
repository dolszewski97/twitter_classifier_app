import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:twitter_classifier_app/datatypes/analise_stats.dart';
import 'package:twitter_classifier_app/datatypes/tweet.dart';
import 'package:twitter_classifier_app/screens/analise_user/tweet_card.dart';
import 'package:twitter_classifier_app/screens/my_user/pie_chart.dart';

class ShowTweetsBody extends StatefulWidget {
  final String twitterAccount;

  const ShowTweetsBody({Key key, this.twitterAccount}) : super(key: key);
  @override
  _ShowTweetsBodyState createState() => _ShowTweetsBodyState();
}

class _ShowTweetsBodyState extends State<ShowTweetsBody> {
  @override
  initState() {
    super.initState();
    //Fetch directly to server to get last X tweets
  }

  //Build method for custom user tweets analise body
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //First element - analise stats results with chart
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Custom analise stats",
                  style: Theme.of(context).textTheme.headline1,
                ),
                Text(
                  tweetsDataset[0].tweetAuthorName,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          PieChartStats(statsDataset),
          SizedBox(height: 25),

          //Scrollable ListView with tweets
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Column(
              children: <Widget>[
                Text(
                  tweetsDataset[0].tweetAuthorName + "'s tweets:",
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.85,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.013),
                  padding: EdgeInsets.only(
                    top: size.height * 0.01,
                    bottom: size.height * 0.01,
                  ),
                  decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45),
                      )),
                  child: Container(
                    child: ListView.builder(
                        //ListView builder that shows TweetCards with received tweets
                        itemCount: tweetsDataset.length,
                        itemBuilder: (BuildContext context, int index) {
                          return TweetCard(tweetsDataset[index]);
                        }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
