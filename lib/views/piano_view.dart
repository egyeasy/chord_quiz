import 'package:flutter/material.dart';
import 'package:piano/piano.dart';

class PianoView extends StatefulWidget {
  const PianoView({Key? key}) : super(key: key);

  @override
  State<PianoView> createState() => _PianoViewState();
}

class _PianoViewState extends State<PianoView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: InteractivePiano(
        highlightedNotes: [NotePosition(note: Note.C, octave: 2)],
        noteRange: NoteRange(
          NotePosition(note: Note.C, octave: 2),
          NotePosition(note: Note.C, octave: 3),
        ),
        highlightColor: Colors.blueAccent,
        hideNoteNames: true,
      ),
    );
  }
}
