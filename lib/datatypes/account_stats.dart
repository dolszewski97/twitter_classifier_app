//Account stats model
class AccountStats {
  final int _numOfFollows;
  final int _numOfTweets;
  final DateTime _createdAt;

  AccountStats({int numOfFollows, int numOfTeets, DateTime createdAt})
      : _numOfFollows = numOfFollows,
        _numOfTweets = numOfTeets,
        _createdAt = createdAt;

  factory AccountStats.fromJson(Map<String, dynamic> json) {
    String date = json['created'];
    return AccountStats(
      numOfFollows: json['num_of_follows'],
      createdAt: DateTime.parse(date),
      numOfTeets: json['num_of_tweets'],
    );
  }

  Map<String, dynamic> get map {
    return {
      "numOfFollows": _numOfFollows,
      "numOfTweets": _numOfTweets,
      "createdAt": _createdAt,
    };
  }

  int get numOfFollows {
    return _numOfFollows;
  }

  int get numOfTweets {
    return _numOfTweets;
  }

  DateTime get createdAt {
    return _createdAt;
  }
}
