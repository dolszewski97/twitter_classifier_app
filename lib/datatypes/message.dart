import 'package:twitter_classifier_app/datatypes/account_stats.dart';
import 'package:twitter_classifier_app/datatypes/analise_stats.dart';
import 'package:twitter_classifier_app/datatypes/tweet.dart';

//Message model
class Message {
  List<Tweet> _tweets;
  AccountStats _accountStats;
  AnaliseStats _analiseStats;

  Message(this._tweets, this._accountStats, this._analiseStats);

  static Message createEmptyMessage() {
    return Message([], null, null);
  }

  List<Tweet> get tweets {
    return _tweets;
  }

  AccountStats get accountStats {
    return _accountStats;
  }

  AnaliseStats get analiseStats {
    return _analiseStats;
  }
}
