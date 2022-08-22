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

  @override
  Widget build(BuildContext context) {
    _isPlayingProvider = Provider.of<IsPlayingProvider>(context, listen: true);
    _intervalSecondsProvider = Provider.of<IntervalSecondsProvider>(context, listen: true);

    return Container(
      height: 200,
      width: 500,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
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
          ),
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
          Text(
            "가",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
