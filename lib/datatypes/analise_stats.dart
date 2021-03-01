import 'package:twitter_classifier_app/connectors/database_connect.dart';

//Analise stats model
class AnaliseStats {
  int _id = 0;
  int _total = 0;
  int _positive = 0;
  int _negative = 0;
  int _neutral = 0;

  AnaliseStats({int total, int pos, int neg, int neu})
      : _total = total,
        _positive = pos,
        _negative = neg,
        _neutral = neu;

  factory AnaliseStats.fromJson(Map<String, dynamic> json) {
    return AnaliseStats(
      total: json['total'],
      pos: json['pos'],
      neg: json['neg'],
      neu: json['neu'],
    );
  }

  factory AnaliseStats.fromMap(Map<String, dynamic> map) {
    return AnaliseStats(
      total: map[columnTotal],
      pos: map[columnPositive],
      neg: map[columnNegative],
      neu: map[columnNeutral],
    );
  }

  Map<String, dynamic> get map {
    return {
      "total": _total,
      "pos": _positive,
      "neg": _negative,
      "neu": _neutral,
    };
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTotal: _total,
      columnPositive: _positive,
      columnNegative: _negative,
      columnNeutral: _neutral,
    };
    if (_id != null) {
      map[columnId] = _id;
    }
    return map;
  }

  updateStats(AnaliseStats stats) {
    if (stats.total != null) {
      this._total += stats.total;
      this._neutral += stats.neutral;
      this._positive += stats.positive;
      this._negative += stats.negative;
      if (this._negative + this._neutral + this._positive != this._total) {
        print("Something wrong with stats");
      }
    }
  }

  int get id {
    return _id;
  }

  int get total {
    return _total;
  }

  int get positive {
    return _positive;
  }

  int get negative {
    return _negative;
  }

  int get neutral {
    return _neutral;
  }

  String posP() {
    double value = (_positive / _total) * 100;
    return value.toStringAsPrecision(2);
  }

  String negP() {
    double value = (_negative / _total) * 100;
    return value.toStringAsPrecision(2);
  }

  String neuP() {
    double value = (_neutral / _total) * 100;
    return value.toStringAsPrecision(2);
  }
}

AnaliseStats statsDataset = AnaliseStats(total: 5, pos: 2, neg: 2, neu: 1);
