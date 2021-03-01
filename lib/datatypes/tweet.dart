import 'package:twitter_classifier_app/connectors/database_connect.dart';

//Tweet's model
class Tweet {
  int _id;
  final String _tweetAuthor;
  final String _tweetBody;
  final double _negProb;
  final double _posProb;
  final double _neuProb;
  final String _result;
  final double _cv;

  Tweet(
      {String author,
      String body,
      double negP,
      double posP,
      double neuP,
      String res,
      double cv})
      : _tweetAuthor = author,
        _tweetBody = body,
        _negProb = negP,
        _posProb = posP,
        _neuProb = neuP,
        _result = res,
        _cv = cv;

  Map<String, dynamic> get map {
    return {
      "tweetAuthor": _tweetAuthor,
      "tweetBody": _tweetBody,
      "negativeProbability": _negProb,
      "positiveProbability": _posProb,
      "neutralProbability": _neuProb,
      "result": _result,
      "compoundValue": _cv
    };
  }

  factory Tweet.fromJson(Map<String, dynamic> json) {
    return Tweet(
      author: json['author'],
      body: json['body'],
      negP: json['neg_prob'],
      posP: json['pos_prob'],
      neuP: json['neu_prob'],
      res: json['result'],
      cv: json['cv'],
    );
  }

  factory Tweet.fromMap(Map<String, dynamic> map) {
    return Tweet(
      author: map[columnAuthor],
      body: map[columnBody],
      negP: map[columnNProb],
      posP: map[columnPProb],
      neuP: map[columnNeuProb],
      res: map[columnResult],
      cv: map[columnCV],
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnAuthor: _tweetAuthor,
      columnBody: _tweetBody,
      columnPProb: _posProb,
      columnNProb: _negProb,
      columnNeuProb: _neuProb,
      columnResult: _result,
      columnCV: _cv,
    };
    if (_id != null) {
      map[columnId] = _id;
    }
    return map;
  }

  String get tweetAuthor {
    return _tweetAuthor;
  }

  String get tweetBody {
    return _tweetBody;
  }

  double get negProb {
    return _negProb;
  }

  double get posProb {
    return _posProb;
  }

  double get neuProb {
    return _neuProb;
  }

  String get result {
    return _result;
  }

  double get cv {
    return _cv;
  }

  String get tweetAuthorName {
    var name = _tweetAuthor.split("(");
    var result = name[0];
    return result;
  }

  String get tweetAuthorNickname {
    var name = _tweetAuthor.split("(");
    String result = "(" + name[1];
    return result;
  }
}

List<Tweet> tweetsDataset = [
  Tweet(
      author: "anon(anon01)",
      body: "My first tweet!",
      negP: 0.06,
      posP: 0.94,
      neuP: 0.00,
      res: "pos",
      cv: 0.76),
  Tweet(
      author: "anon(anon01)",
      body: "My second tweet! This is awesome.",
      negP: 0.01,
      posP: 0.99,
      neuP: 0.00,
      res: "pos",
      cv: 0.92),
  Tweet(
      author: "anon(anon01)",
      body:
          "My third tweet! Tonight I found that there aren't functions that I want.",
      negP: 0.55,
      posP: 0.45,
      neuP: 0.00,
      res: "neg",
      cv: -0.21),
  Tweet(
      author: "anon(anon01)",
      body: "Okey. There isn't as good as I read.",
      negP: 0.71,
      posP: 0.29,
      neuP: 0.00,
      res: "neg",
      cv: -0.90),
  Tweet(
      author: "anon(anon01)",
      body: "My last tweet.",
      negP: 0.50,
      posP: 0.50,
      neuP: 0.00,
      res: "neu",
      cv: 0.00),
];
