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

  late IsPlayingProvider _isPlayingProvider;

  @override
  Widget build(BuildContext context) {
    _isPlayingProvider = Provider.of<IsPlayingProvider>(context, listen: true);

    return Container(
      height: 200,
      width: 500,
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
        ],
      ),
    );
  }
}
