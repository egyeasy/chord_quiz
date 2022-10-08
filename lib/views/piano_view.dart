import 'package:chordquiz/providers/selected_chord_provider.dart';
import 'package:flutter/material.dart';
import 'package:piano/piano.dart';
import 'package:provider/provider.dart';

class PianoView extends StatefulWidget {
  const PianoView({Key? key}) : super(key: key);

  @override
  State<PianoView> createState() => _PianoViewState();
}

class _PianoViewState extends State<PianoView> {
  late SelectedChordProvider _selectedChordProvider;

  @override
  void didChangeDependencies() {
    _selectedChordProvider = Provider.of<SelectedChordProvider>(context, listen: true);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: InteractivePiano(
        highlightedNotes: _selectedChordProvider.selectedChord?.getNotePositionsForChord() ?? [],
        noteRange: NoteRange(
          NotePosition(note: Note.C, octave: 1),
          NotePosition(note: Note.C, octave: 3),
        ),
        highlightColor: Colors.blueAccent,
        hideNoteNames: true,
      ),
    );
  }
}
