import 'dart:async';
import 'dart:ffi';

import 'package:noise_meter/noise_meter.dart';

// yaml plugin: noise_meter:
/// #How to use this recorder [RecorderUtil]
///
/// before starting any new recording create and initialize this class for every variable
///  util = RecorderUtil();
/// initialize it in a function call or in initState before using it ie.
/// methods Available [start] and [stop] directly use it [RecorderUtil] recorderUtil.start() or recorderUtil.stop

/// [References]
///
/// https://www.healthyhearing.com/report/52514-What-is-a-decibel
/// https://pub.dev/packages/noise_meter

/// [Permissions]
///
/// <uses-permission android:name="android.permission.RECORD_AUDIO" />
/// <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />

/// [Methods]
///
/// start() : void
/// stop() : void
/// start_for_seconds(time) : void
/// getAverageSoundForInterval : double

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

class RecorderUtil {
  StreamSubscription<NoiseReading> _noiseSubscription;
  NoiseMeter _noiseMeter;

  //storing the list of decimal data
  List sounddata = [];
  double average_sound = 0.00;

  RecorderUtil() {
    _noiseMeter = new NoiseMeter();
  }

  /// This will add decibel [data] to the list for the Duration
  void onData(NoiseReading noiseReading) {
    print("data : " + noiseReading.toString());
    sounddata.add(noiseReading.db.toDouble());
  }

  void onError(Object error) {
    print(error.toString());
  }

  void start() async {
    sounddata.clear();
    try {
      _noiseSubscription = _noiseMeter.noiseStream.listen(onData);
    } catch (err) {
      print(err);
    }
  }

  void start_for_seconds(int time) async {
    sounddata.clear();
    try {
      _noiseSubscription = _noiseMeter.noiseStream.listen(onData);
      Future.delayed(Duration(seconds: time), () {
        _noiseSubscription.cancel();
      });
    } catch (err) {
      print(err);
    }
  }

  stop() async {
    // average_sound = getAverageSoundForInterval(sounddata);
    try {
      if (_noiseSubscription != null) {
        _noiseSubscription.cancel();
        _noiseSubscription = null;
      }
    } catch (err) {
      print('stopRecorder error: $err');
    }
    return average_sound;
  }

  double getAverageSoundForInterval() {
    double av = 0.00;
    for (int i = 0; i < sounddata.length; i++) av = av + sounddata[i];
    average_sound = av / sounddata.length;
    return av / sounddata.length;
  }
}
