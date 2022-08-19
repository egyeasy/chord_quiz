class ChordManager {
  static const pitchAlphabets = ["C", "D", "E", "F", "G", "A", "B"];
  static const triads = ["M", "m"];
  static const sevenths = ["M7", "m7", "7"];
  static const String sharp = "#";
  static const String flat = "b";

  static List<String> getPitchList({
    required bool withSharp,
    required bool withFlat,
  }) {
    List<String> pitchList = pitchAlphabets;

    if (withSharp) {
      for (var alphabet in pitchAlphabets) {
        if (alphabet != "E" || alphabet != "B") {
          String pitch = alphabet + sharp;
          pitchList.add(pitch);
        }
      }
    }

    if (withFlat) {
      for (var alphabet in pitchAlphabets) {
        if (alphabet != "C" || alphabet != "F") {
          String pitch = alphabet + flat;
          pitchList.add(pitch);
        }
      }
    }

    return pitchList;
  }

  static List<String> getChordList({
    required bool withTriads,
    required bool withSevenths,
  }) {
    List<String> chordList = [];

    if (withTriads) {
      chordList += triads;
    }

    if (withSevenths) {
      chordList += sevenths;
    }

    return chordList;
  }
}
