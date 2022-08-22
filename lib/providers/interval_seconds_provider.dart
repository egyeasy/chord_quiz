import 'package:flutter/material.dart';

class IntervalSecondsProvider extends ChangeNotifier {
  int _intervalSeconds = 5;

  int get intervalSeconds => _intervalSeconds;

  set intervalSeconds(int intervalSeconds) {
    _intervalSeconds = intervalSeconds;
    notifyListeners();
  }
}
