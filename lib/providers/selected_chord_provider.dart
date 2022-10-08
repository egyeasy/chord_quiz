import 'package:chordquiz/utils/chords.dart';
import 'package:flutter/material.dart';

class SelectedChordProvider with ChangeNotifier {
  Chord? _selectedChord;

  Chord? get selectedChord => _selectedChord;

  set selectedChord(Chord? chord) {
    _selectedChord = chord;
    notifyListeners();
  }
}
