import 'package:chordquiz/providers/chord_filter_provider.dart';
import 'package:chordquiz/providers/interval_seconds_provider.dart';
import 'package:chordquiz/providers/is_playing_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  var isPlaying = true;

  final playPauseIconSize = 100.0;
  final intervalChangeIconSize = 20.0;

  late IsPlayingProvider _isPlayingProvider;
  late IntervalSecondsProvider _intervalSecondsProvider;
  late ChordFilterProvider _chordFilterProvider;

  @override
  Widget build(BuildContext context) {
    _isPlayingProvider = Provider.of<IsPlayingProvider>(context, listen: true);
    _intervalSecondsProvider = Provider.of<IntervalSecondsProvider>(context, listen: true);
    _chordFilterProvider = Provider.of<ChordFilterProvider>(context, listen: true);

    return Container(
      height: 200,
      width: 500,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          intervalSecondsWidget(),
          SizedBox(
            height: playPauseIconSize,
            width: playPauseIconSize,
            child: IconButton(
              icon: Icon(
                _isPlayingProvider.isPlaying ? Icons.pause_circle : Icons.play_circle,
                color: Colors.white,
                size: playPauseIconSize,
              ),
              padding: const EdgeInsets.all(0),
              onPressed: () {
                _isPlayingProvider.isPlaying = !_isPlayingProvider.isPlaying;
                setState(() {});
              },
            ),
          ),
          _chordFilterWidget(),
        ],
      ),
    );
  }

  Widget intervalSecondsWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
              size: intervalChangeIconSize,
            ),
            padding: const EdgeInsets.all(0),
            onPressed: () {
              _intervalSecondsProvider.intervalSeconds += 1;
              setState(() {});
            },
          ),
          Text(
            _intervalSecondsProvider.intervalSeconds.toString(),
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.remove,
              color: Colors.white,
              size: intervalChangeIconSize,
            ),
            padding: const EdgeInsets.all(0),
            onPressed: () {
              if (_intervalSecondsProvider.intervalSeconds > 1) {
                _intervalSecondsProvider.intervalSeconds -= 1;
              }
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _chordFilterWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _filterCheckboxWidget(
          "Triad",
          _chordFilterProvider.withTriads,
          () {
            _chordFilterProvider.withTriads = !_chordFilterProvider.withTriads;
          },
        ),
        _filterCheckboxWidget(
          "Seventh",
          _chordFilterProvider.withSevenths,
          () {
            _chordFilterProvider.withSevenths = !_chordFilterProvider.withSevenths;
          },
        ),
      ],
    );
  }

  Widget _filterCheckboxWidget(String title, bool isChecked, Function onCheckboxValueChanged) {
    return Material(
      color: Colors.black,
      child: InkWell(
        onTap: () {
          onCheckboxValueChanged();
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 24.0,
                width: 24.0,
                child: IgnorePointer(
                  child: Checkbox(
                    checkColor: Colors.white,
                    value: isChecked,
                    onChanged: null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
