import 'package:chordquiz/managers/chord_manager.dart';
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

  late List<String> pitchList;
  late List<String> chordList;

  bool withSharp = false;
  bool withFlat = true;

  late bool withTriads;
  late bool withSevenths;

  @override
  void didChangeDependencies() {
    _settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
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
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      alignment: Alignment.center,
      child: Text(pitchList.first + chordList.first),
    );
  }
}
