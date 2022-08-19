import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  bool _withTriads = true;
  bool _withSevenths = true;

  bool get withTriads => _withTriads;
  bool get withSevenths => _withSevenths;
}
