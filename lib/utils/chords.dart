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

List<NotePosition> getNotePositionsForChord(
  NotePosition note,
  ChordIntervalType interval,
  ChordNumberType type,
) {
  List<NotePosition> notes = [note];

  if (isWrongChord(interval, type)) {
    throw Exception("WRONG CHORD TYPE");
  }

  switch (interval) {
    case ChordIntervalType.major:
    case ChordIntervalType.dominant:
      notes.add(note.addPitch(4));
      break;
    case ChordIntervalType.minor:
      notes.add(note.addPitch(3));
      break;
    default:
  }

  notes.add(note.addPitch(7));

  switch (type) {
    case ChordNumberType.seventh:
      switch (interval) {
        case ChordIntervalType.major:
          notes.add(note.addPitch(11));
          break;
        case ChordIntervalType.minor:
        case ChordIntervalType.dominant:
          notes.add(note.addPitch(10));
          break;
        default:
      }
  }

  return notes;
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

    String resultString = baseNotePosition!.note.name + chordIntervalType!.name + chordNumberType!.name;

    return resultString;
  }
}
