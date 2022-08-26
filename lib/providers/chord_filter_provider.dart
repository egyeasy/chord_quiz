import 'package:flutter/material.dart';

class ChordFilterProvider with ChangeNotifier {
  bool _withTriads = true;
  bool _withSevenths = true;

  bool get withTriads => _withTriads;
  bool get withSevenths => _withSevenths;

  set withTriads(bool withTriads) {
    _withTriads = withTriads;
    notifyListeners();
  }

  set withSevenths(bool withSevenths) {
    _withSevenths = withSevenths;
    notifyListeners();
  }
}
