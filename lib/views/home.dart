import 'package:chordquiz/views/display_view.dart';
import 'package:chordquiz/views/piano_view.dart';
import 'package:chordquiz/views/settings_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DisplayView(),
          PianoView(),
          SettingsView(),
        ],
      ),
    );
  }
}
