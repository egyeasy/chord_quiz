import 'package:flutter/material.dart';

class IsPlayingProvider extends ChangeNotifier {
  bool _isPlaying = false;

  bool get isPlaying => _isPlaying;

  set isPlaying(bool isPlaying) {
    _isPlaying = isPlaying;
    notifyListeners();
  }
}
