import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:twitter_classifier_app/constraints.dart';
import 'package:twitter_classifier_app/datatypes/analise_stats.dart';
import 'package:twitter_classifier_app/datatypes/message.dart';
import 'package:twitter_classifier_app/datatypes/tweet.dart';

final String tableTweets = 'tweets';
final String tableAnaliseStats = 'stats';
final String columnId = 'id';
final String columnAuthor = 'tweetAuthor';
final String columnBody = 'tweetBody';
final String columnPProb = 'posProb';
final String columnNProb = 'negProb';
final String columnNeuProb = 'neuProb';
final String columnResult = 'result';
final String columnCV = 'cv';
final String columnTotal = 'total';
final String columnPositive = 'positive';
final String columnNegative = 'negative';
final String columnNeutral = 'neutral';

/*
  Class that provides communication with local SQLite database
*/
class DatabaseConnect {
  static final _databaseName = 'tweets.db';
  var databaseStatus = false;
  bool isDbEmpty;
  //Local variables for tweets and stats - we load data from database only on app's lanuch
  List<Tweet> tweets = [];
  AnaliseStats stats = AnaliseStats();

  DatabaseConnect._privateConstructor();
  static final DatabaseConnect instance = DatabaseConnect._privateConstructor();
  static Database _database;

  //Database getter
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    databaseStatus = _database.isOpen;
    return _database;
  }

  //Database initializer
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  //Method that creates tables for tweets and analise stats in database on app's first lanuch
  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableTweets (
      $columnId INTEGER PRIMARY KEY,
      $columnAuthor TEXT NOT NULL,
      $columnBody TEXT NOT NULL,
      $columnPProb REAL NOT NULL,
      $columnNProb REAL NOT NULL,
      $columnNeuProb REAL NOT NULL,
      $columnResult TEXT NOT NULL,
      $columnCV REAL NOT NULL
    )
    ''');

    await db.execute('''
    CREATE TABLE $tableAnaliseStats (
      $columnId INTEGER PRIMARY KEY,
      $columnTotal INTEGER NOT NULL,
      $columnPositive INTEGER NOT NULL,
      $columnNegative INTEGER NOT NULL,
      $columnNeutral INTEGER NOT NULL
    )
    ''');
  }

  //Database insert method for tweets; ignore conflicts
  Future<int> insertTweet(Tweet tweet) async {
    Database db = await database;
    int id = await db.insert(tableTweets, tweet.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
    Constraints.isDatabaseEmpty = false;
    Constraints.storeAllInSharedPrefs();
    return id;
  }

  //Database insert method for stats
  Future<int> insertStats(AnaliseStats stats) async {
    Database db = await database;
    int id = await db.insert(tableAnaliseStats, stats.toMap());
    Constraints.isDatabaseEmpty = false;
    Constraints.storeAllInSharedPrefs();
    return id;
  }

  //Method that returns number of tweets in database
  Future<int> countTweets() async {
    Database db = await database;
    var queryResult = await db.rawQuery('SELECT COUNT (*) FROM $tableTweets');
    int count = Sqflite.firstIntValue(queryResult);
    return count;
  }

  //Method that load's stats from database
  getAnaliseStats() async {
    Database db = await database;
    var queryResult = await db.rawQuery('SELECT * FROM $tableAnaliseStats');
    stats = AnaliseStats.fromMap(queryResult.first);
  }

  //Method that load's tweets from database
  getTweets() async {
    Database db = await database;
    tweets.clear();
    int id = 1;
    var queryResult =
        await db.rawQuery('SELECT * FROM $tableTweets ORDER BY $columnId');
    if (queryResult.isNotEmpty) {
      queryResult.forEach((map) {
        tweets.add(Tweet.fromMap(map));
        id = id + 1;
      });
    }
  }

  //Method that updates stats stored in database
  updateStats(AnaliseStats stats) async {
    Database db = await database;
    var queryResult = await db.rawQuery('SELECT * FROM $tableAnaliseStats');
    if (queryResult.isEmpty) {
      await insertStats(stats);
    } else {
      AnaliseStats currentStats = AnaliseStats.fromMap(queryResult.first);
      try {
        if (currentStats.total != null) {
          await db.update(tableAnaliseStats, stats.toMap(),
              where: "id == ?", whereArgs: [0]);
        }
      } catch (Exception) {
        //Silented NULL exception
      }
    }
  }

  //Method that checks, if tweets table is empty
  Future<bool> isEmpty() async {
    Database db = await database;
    var queryResult =
        await db.query(tableTweets, where: 'id == ?', whereArgs: [1]);
    return queryResult.isEmpty;
  }

  //Method that updates local tweets and stats variables
  updateLocalVariables(var newTweets, var newStats) {
    tweets.addAll(newTweets);
    if (stats.total == null) {
      stats = newStats;
    } else {
      stats.updateStats(newStats);
    }
  }

  /*
    Method responsible for synchronization between operations on database and
    fetchs to server
  */
  Future<Message> getTweetsFromDatabase() async {
    if (isDbEmpty == null) {
      isDbEmpty = Constraints.isDatabaseEmpty;
      Constraints.storeAllInSharedPrefs();
    }

    //First app's lanuch fetch - empty database and empty local list of tweets
    if (isDbEmpty == true && tweets.isEmpty) {
      tweets = tweetsDataset;
      stats = statsDataset;
      tweets.forEach((element) {
        insertTweet(element);
      });
      insertStats(stats);
    }

    //Restarted app - backup in database, but local tweets list is empty
    else if (!isDbEmpty && tweets.isEmpty) {
      await getTweets();
      await getAnaliseStats();
    }

    //Reloaded widget - just fetch new tweets
    else if (tweets.isNotEmpty) {}

    //updateLocalVariables(message.tweets, message.analiseStats);
    Constraints.isDatabaseEmpty = false;
    return Message(tweets.reversed.toList(), null, stats);
  }
}
