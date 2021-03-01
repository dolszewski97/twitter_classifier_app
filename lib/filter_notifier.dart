import 'package:flutter/widgets.dart';

class FilterNotifier extends ChangeNotifier {
  int id;

  void setId(int id) {
    this.id = id;
    notifyListeners();
  }
}
