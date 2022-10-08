library chords;

import 'package:piano/piano.dart';

enum ChordIntervalType {
  major,
  minor,
  dominant,
}

extension ChordIntervalTypeExtension on ChordIntervalType {
  String get name {
    switch (this) {
      case ChordIntervalType.major:
        return "M";
      case ChordIntervalType.minor:
        return "m";
      case ChordIntervalType.dominant:
        return "";
      default:
        return "";
    }
  }
}

enum ChordNumberType {
  triad,
  seventh,
}

extension ChordNumberTypeExtension on ChordNumberType {
  String get name {
    switch (this) {
      case ChordNumberType.triad:
        return "";
      case ChordNumberType.seventh:
        return "7";
      default:
        return "";
    }
  }
}

NotePosition pitchToNotePosition(int pitch) {
  switch (pitch % 12) {
    case 0:
      return NotePosition(note: Note.C, octave: 1);
    case 1:
      return NotePosition(note: Note.C, accidental: Accidental.Sharp, octave: 1);
    case 2:
      return NotePosition(note: Note.D, octave: 1);
    case 3:
      return NotePosition(note: Note.D, accidental: Accidental.Sharp, octave: 1);
    case 4:
      return NotePosition(note: Note.E, octave: 1);
    case 5:
      return NotePosition(note: Note.F, octave: 1);
    case 6:
      return NotePosition(note: Note.F, accidental: Accidental.Sharp, octave: 1);
    case 7:
      return NotePosition(note: Note.G, octave: 1);
    case 8:
      return NotePosition(note: Note.G, accidental: Accidental.Sharp, octave: 1);
    case 9:
      return NotePosition(note: Note.A, octave: 1);
    case 10:
      return NotePosition(note: Note.A, accidental: Accidental.Sharp, octave: 1);
    case 11:
      return NotePosition(note: Note.B, octave: 1);
    default:
      throw Exception("wrong pitch");
  }
}

extension NotePositionHelpers2 on NotePosition {
  NotePosition addPitch(int added) {
    int result = pitch + added;

    return pitchToNotePosition(result);
  }
}

bool isWrongChord(ChordIntervalType interval, ChordNumberType type) {
  if (interval == ChordIntervalType.dominant && type == ChordNumberType.triad) {
    return true;
  }
  return false;
}

class Chord {
  NotePosition? baseNotePosition;
  ChordIntervalType? chordIntervalType;
  ChordNumberType? chordNumberType;

  Chord(
    this.baseNotePosition,
    this.chordIntervalType,
    this.chordNumberType,
  );

  bool isValid() {
    return !(baseNotePosition == null || chordIntervalType == null || chordNumberType == null);
  }

  String getString() {
    if (!isValid()) {
      throw Exception("Invalid Chord");
    }

    String resultString = baseNotePosition!.note.name +
        baseNotePosition!.accidental.symbol +
        chordIntervalType!.name +
        chordNumberType!.name;

    return resultString;
  }

  List<NotePosition> getNotePositionsForChord() {
    if (!isValid()) {
      throw Exception("Invalid Chord");
    }

    if (isWrongChord(chordIntervalType!, chordNumberType!)) {
      throw Exception("WRONG CHORD TYPE");
    }

    List<NotePosition> notes = [];
    notes.add(baseNotePosition!.addPitch(0));

    switch (chordIntervalType) {
      case ChordIntervalType.major:
      case ChordIntervalType.dominant:
        notes.add(baseNotePosition!.addPitch(4));
        break;
      case ChordIntervalType.minor:
        notes.add(baseNotePosition!.addPitch(3));
        break;
      default:
    }

    notes.add(baseNotePosition!.addPitch(7));

    switch (chordNumberType) {
      case ChordNumberType.seventh:
        switch (chordIntervalType) {
          case ChordIntervalType.major:
            notes.add(baseNotePosition!.addPitch(11));
            break;
          case ChordIntervalType.minor:
          case ChordIntervalType.dominant:
            notes.add(baseNotePosition!.addPitch(10));
            break;
          default:
        }
    }

    return notes;
  }
}
