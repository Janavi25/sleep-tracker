import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:sleep_tracker/NoiseTracker/NoiseMeter.dart';

class BackgroundTask {
  //Declaring the method Channel
  var bg_channel = MethodChannel("sleep_tracker/background_task");
  var data;
  String uid = null;
  var firestore = FirebaseFirestore.instance;

  //Constructor
  BackgroundTask() {
    CallNativeAndReturnCallBackDart();
  }

  CallNativeAndReturnCallBackDart() {
    bg_channel.setMethodCallHandler((call) async {
      if (call.method == "background_task") {
        final data = call.arguments;
        print("Native Data passed (print:flutter) :: " + "${data.toString()}");
        updateUserSound();
      }
    });
  }


/// It will retrieve the user latest sound for [10] and update it to the Database after calculating the average
  updateUserSound() {
    RecorderUtil util = RecorderUtil();
    util.start();
    Future.delayed(Duration(seconds: 10), () {
      util.stop();
      double _db = util.getAverageSoundForInterval();
      User user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        uid = user.uid;
      } else
        return;
      var prev = null;

      //get the previous average decibels of the user from Database
      firestore.collection("users").doc(uid).get().then((value) {
        var prev = value["db"];
      });

      //no db field in firestore as db
      if (prev == null)
        firestore.collection("users").doc(uid).update({"db": _db});

      //updte the latest average db of the user in the user details
      firestore.collection("users").doc(uid).update({"db": (prev + _db) / 2});
    });
  }

  getData() {
    return data;
  }
}
