import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_classifier_app/connectors/database_connect.dart';
import 'package:twitter_classifier_app/constraints.dart';
import 'package:twitter_classifier_app/datatypes/analise_stats.dart';
import 'package:twitter_classifier_app/datatypes/message.dart';
import 'package:twitter_classifier_app/screens/analise_user/tweet_card.dart';
import 'package:twitter_classifier_app/screens/my_home_page.dart';
import 'package:twitter_classifier_app/screens/my_user/pie_chart.dart';
import 'package:twitter_classifier_app/screens/settings/settings_screen.dart';

class MyUserHomeScreen extends StatefulWidget {
  _MyUserHomeScreenState createState() => _MyUserHomeScreenState();
}

class _MyUserHomeScreenState extends State<MyUserHomeScreen> {
  var _futureMessage;
  AnaliseStats analiseStats;
  String username;
  Constraints consts;
  DatabaseConnect database = DatabaseConnect.instance;

  @override
  void initState() {
    super.initState();
    //Fetch to database and server for tweets
    _futureMessage = database.getTweetsFromDatabase();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //Build method for MyHomeScreen body - app's default and primary screen
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<Constraints>(
        create: (_) => Constraints(),
        child: Consumer<Constraints>(builder: (context, notifier, child) {
          return FutureBuilder<Message>(
              future: _futureMessage,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var message = snapshot.data;
                  return SingleChildScrollView(
                    controller: MyHomePage.controller,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 28),

                        //First row - Hello "username" phrase and appp settings icon
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text("  Hello, " + Constraints.username,
                                    style:
                                        Theme.of(context).textTheme.headline1),
                              ),
                              Container(
                                child: IconButton(
                                  icon: Icon(Icons.settings),
                                  color: Colors.white,
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SettingsScreen())),
                                ),
                              )
                            ],
                          ),
                        ),

                        //Analise stats chart
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "   Your account stats:",
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        PieChartStats(message.analiseStats),
                        SizedBox(height: 25),

                        //Scrollable ListView with tweets
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "   Your tweets:",
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height + 30,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                margin:
                                    EdgeInsets.only(top: size.height * 0.013),
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
                                  //Build ListView with TweetCards that shows tweets
                                  child: ListView.builder(
                                      itemCount: message.analiseStats.total,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return TweetCard(message.tweets[index]);
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
                return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              });
        }));
  }
}
