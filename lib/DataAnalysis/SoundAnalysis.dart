class SoundAnalysis {
  var decibels;

  SoundAnalysis(var db) {
    db = decibels;
  }

  /// Normal conversation – 60 dB
  /// Heavy city traffic – 85 dB
  /// Lawn mower – 90 dB
  /// Audio headset player at maximum volume – 105 dB
  /// Sirens – 120 dB
  /// Concerts – 120 dB
  ///Sporting events – 105 to 130 dB (depending upon the stadium)
  /// Fireworks – 140 to 160 dB
  /// Firearms – 150 dB and higher
  /// Breathing - 10 dB
  /// conversation - 50
  /// vacum cleaner - 70
  /// heavy traffic 80-90
  /// motorcycle - 100
  /// siren - 120
  /// shotgun - 160

  getSymptopms() {
    List<String> sym = [];
    if (decibels > 60) {
      sym.add("Irritation");
    } else if (decibels > 85) {
      sym.add("Irritation");
      sym.add("HeadAche");
    } else if (decibels > 100) {
      sym.add("hearing Loss");
      sym.add("HeadAche");
    } else if (decibels > 120) {
      sym.add("anxiety");
      sym.add("hearing Loss");
      sym.add("HeadAche");
      sym.add("sleep deprivation");
    }
    return sym;
  }
}
