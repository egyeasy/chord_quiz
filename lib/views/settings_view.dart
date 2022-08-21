import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  var isPlaying = true;

  final playPauseIconSize = 100.0;

  @override
  Widget build(BuildContext context) {
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
                isPlaying ? Icons.play_circle : Icons.pause_circle,
                color: Colors.white,
                size: playPauseIconSize,
              ),
              padding: const EdgeInsets.all(0),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
