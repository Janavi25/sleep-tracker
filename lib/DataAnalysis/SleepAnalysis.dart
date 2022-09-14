class SleepAnalysis {
  var averageSleep;

  SleepAnalysis(var sleep) {
    averageSleep = sleep;
  }

  getSymptopms() {
    List<String> sym = [];

    if (averageSleep < 6) {
      sym.add("Increased risk of stress");
      sym.add("Dark undereye circles");
    } else if (averageSleep < 3) {
      sym.add("Increased risk of stress");
      sym.add("Dark undereye circles");
      sym.add("Thinking Ability decrease");
    } else if (averageSleep < 1) {
      sym.add("Anxiety");
      sym.add("Heightened stress levels");
      sym.add("Puffy eyes");
      sym.add("Slow reaction time");
      sym.add("HeadAche");
      sym.add("Impaired memory");
      sym.add("Extreme fatigue");
      sym.add("Dark undereye circles");
      sym.add("Thinking Ability decrease");
      sym.add("delusions");
    }
    return sym;
  }
}
