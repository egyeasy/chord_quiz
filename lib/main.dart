import 'package:chordquiz/providers/is_playing_provider.dart';
import 'package:chordquiz/providers/settings_provider.dart';
import 'package:chordquiz/views/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<SettingsProvider>(create: (_) => SettingsProvider()),
          ChangeNotifierProvider<IsPlayingProvider>(create: (_) => IsPlayingProvider()),
        ],
        child: const HomeView(),
      ),
    );
  }
}
