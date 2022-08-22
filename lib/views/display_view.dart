import 'dart:async';
import 'dart:math';

import 'package:chordquiz/managers/chord_manager.dart';
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
    if (_isPlayingProvider.isPlaying) {
      if (timer == null || !timer!.isActive) {
        timer = Timer.periodic(const Duration(seconds: 2), (Timer t) => selectPitchAndChord());
      }
    } else {
      timer?.cancel();
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
