import 'dart:async';
import 'dart:math';

import 'package:chordquiz/managers/chord_manager.dart';
import 'package:chordquiz/providers/interval_seconds_provider.dart';
import 'package:chordquiz/providers/is_playing_provider.dart';
import 'package:chordquiz/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayView extends StatefulWidget {
  const DisplayView({Key? key}) : super(key: key);

  @override
  State<DisplayView> createState() => _DisplayViewState();
}

class _DisplayViewState extends State<DisplayView> {
  late SettingsProvider _settingsProvider;
  late IsPlayingProvider _isPlayingProvider;
  late IntervalSecondsProvider _intervalSecondsProvider;

  late List<String> pitchList;
  late List<String> chordList;

  String selectedPitch = "";
  String selectedChord = "";

  bool withSharp = false;
  bool withFlat = true;

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
    _settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
    _isPlayingProvider = Provider.of<IsPlayingProvider>(context, listen: true);
    _intervalSecondsProvider = Provider.of<IntervalSecondsProvider>(context, listen: true);

    withTriads = _settingsProvider.withTriads;
    withSevenths = _settingsProvider.withSevenths;

    pitchList = ChordManager.getPitchList(
      withSharp: withSharp,
      withFlat: withFlat,
    );

    chordList = ChordManager.getChordList(
      withTriads: withTriads,
      withSevenths: withSevenths,
    );

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void selectPitchAndChord() {
    setState(() {
      selectedPitch = pitchList[random.nextInt(pitchList.length)];
      selectedChord = chordList[random.nextInt(chordList.length)];
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
          selectedPitch + selectedChord,
          style: const TextStyle(
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}
