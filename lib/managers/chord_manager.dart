import 'dart:math';

import 'package:chordquiz/utils/chords.dart';
import 'package:piano/piano.dart';

class ChordManager {
  static final pitchNotePositions = [
    NotePosition(note: Note.C, octave: 1),
    NotePosition(note: Note.D, octave: 1),
    NotePosition(note: Note.E, octave: 1),
    NotePosition(note: Note.F, octave: 1),
    NotePosition(note: Note.G, octave: 1),
    NotePosition(note: Note.A, octave: 1),
    NotePosition(note: Note.B, octave: 1),
  ];

  static final random = Random();

  static List<NotePosition> getPitchList({
    required bool withSharp,
    required bool withFlat,
  }) {
    List<NotePosition> pitchList = [...pitchNotePositions];

    if (withSharp) {
      for (var notePosition in pitchNotePositions) {
        if (notePosition.note != Note.E || notePosition.note != Note.B) {
          NotePosition notePositionWithSharp = NotePosition(
            note: notePosition.note,
            octave: notePosition.octave,
            accidental: Accidental.Sharp,
          );
          pitchList.add(notePositionWithSharp);
        }
      }
    }

    if (withFlat) {
      for (var notePosition in pitchNotePositions) {
        if (notePosition.note != Note.C || notePosition.note != Note.F) {
          NotePosition notePositionWithFlat = NotePosition(
            note: notePosition.note,
            octave: notePosition.octave,
            accidental: Accidental.Flat,
          );
          pitchList.add(notePositionWithFlat);
        }
      }
    }

    return pitchList;
  }

  static List<Chord> getCandidateChordList({
    required bool withSharp,
    required bool withFlat,
    required bool withTriads,
    required bool withSevenths,
  }) {
    List<Chord> candidateChordList = [];

    List<NotePosition> pitchList = ChordManager.getPitchList(
      withSharp: withSharp,
      withFlat: withFlat,
    );

    if (withTriads) {
      for (var intervalType in ChordIntervalType.values) {
        candidateChordList += pitchList.map((pitch) => Chord(pitch, intervalType, ChordNumberType.triad)).toList();
      }
    }

    if (withSevenths) {
      for (var intervalType in ChordIntervalType.values) {
        candidateChordList += pitchList.map((pitch) => Chord(pitch, intervalType, ChordNumberType.seventh)).toList();
      }
    }

    return candidateChordList;
  }

  static Chord getRandomChord({
    required bool withSharp,
    required bool withFlat,
    required bool withTriads,
    required bool withSevenths,
  }) {
    List<Chord> candidateChordList = ChordManager.getCandidateChordList(
      withSharp: withSharp,
      withFlat: withFlat,
      withTriads: withTriads,
      withSevenths: withSevenths,
    );

    Chord selectedChord = candidateChordList[random.nextInt(candidateChordList.length)];

    return selectedChord;
  }
}
