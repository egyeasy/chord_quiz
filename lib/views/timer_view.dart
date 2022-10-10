import 'dart:async';
import 'dart:math';

import 'package:chordquiz/providers/interval_seconds_provider.dart';
import 'package:chordquiz/providers/is_playing_provider.dart';
import 'package:chordquiz/providers/selected_chord_provider.dart';
import 'package:chordquiz/utils/chords.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class TimerView extends StatefulWidget {
  const TimerView({Key? key}) : super(key: key);

  @override
  State<TimerView> createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> with SingleTickerProviderStateMixin {
  late IsPlayingProvider _isPlayingProvider;
  late IntervalSecondsProvider _intervalSecondsProvider;
  late SelectedChordProvider _selectedChordProvider;

  Logger logger = Logger();

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
    _isPlayingProvider = Provider.of<IsPlayingProvider>(context, listen: true);
    _intervalSecondsProvider = Provider.of<IntervalSecondsProvider>(context, listen: true);
    _selectedChordProvider = Provider.of<SelectedChordProvider>(context, listen: false);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timer?.cancel();
    if (_isPlayingProvider.isPlaying) {
      if (timer == null || timer!.isActive == false) {
        timer = Timer.periodic(
          Duration(
            seconds: _intervalSecondsProvider.intervalSeconds,
          ),
          (Timer t) => () {
            logger.d(t.tick);
          },
        );
      }
    }

    return LinearProgressIndicator(
      value: 0.50,
    );
  }
}
