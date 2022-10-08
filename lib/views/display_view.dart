import 'dart:async';
import 'dart:math';

import 'package:chordquiz/managers/chord_manager.dart';
import 'package:chordquiz/providers/chord_filter_provider.dart';
import 'package:chordquiz/providers/interval_seconds_provider.dart';
import 'package:chordquiz/providers/is_playing_provider.dart';
import 'package:chordquiz/providers/selected_chord_provider.dart';
import 'package:chordquiz/utils/chords.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayView extends StatefulWidget {
  const DisplayView({Key? key}) : super(key: key);

  @override
  State<DisplayView> createState() => _DisplayViewState();
}

class _DisplayViewState extends State<DisplayView> {
  late ChordFilterProvider _chordFilterProvider;
  late IsPlayingProvider _isPlayingProvider;
  late IntervalSecondsProvider _intervalSecondsProvider;
  late SelectedChordProvider _selectedChordProvider;

  late List<String> pitchList;
  late List<Chord> chordList;

  Chord? selectedChord;

  bool withSharp = true;
  bool withFlat = false;

  late bool withTriads;
  late bool withSevenths;

  Timer? timer;
  final random = Random();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _chordFilterProvider = Provider.of<ChordFilterProvider>(context, listen: true);
    _isPlayingProvider = Provider.of<IsPlayingProvider>(context, listen: true);
    _intervalSecondsProvider = Provider.of<IntervalSecondsProvider>(context, listen: true);
    _selectedChordProvider = Provider.of<SelectedChordProvider>(context, listen: false);

    withTriads = _chordFilterProvider.withTriads;
    withSevenths = _chordFilterProvider.withSevenths;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void selectPitchAndChord() {
    setState(() {
      selectedChord = ChordManager.getRandomChord(
        withSharp: withSharp,
        withFlat: withFlat,
        withTriads: withTriads,
        withSevenths: withSevenths,
      );
      _selectedChordProvider.selectedChord = selectedChord;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: build 할 때마다 cancel 하는 것은 비효율적
    timer?.cancel();
    if (_isPlayingProvider.isPlaying) {
      if (timer == null || timer!.isActive == false) {
        timer = Timer.periodic(
          Duration(
            seconds: _intervalSecondsProvider.intervalSeconds,
          ),
          (Timer t) => selectPitchAndChord(),
        );
      }
    }

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Text(
          selectedChord?.getString() ?? "",
          style: const TextStyle(
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}
