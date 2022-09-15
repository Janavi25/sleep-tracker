import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleep_tracker/NoiseTracker/NoiseMeter.dart';
import 'package:sleep_tracker/controller/constants.dart';
import 'package:workmanager/workmanager.dart';

class BackgroundTask {
  //Declaring the method Channel
  var bg_channel = MethodChannel("sleep_tracker/background_task");
  var data;
  String uid = null;
  var firestore = FirebaseFirestore.instance;
  var simpleTaskKey = "periodicTask";
  //Constructor
  BackgroundTask() {
    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );
    CallNativeAndReturnCallBackDart();
    WorkmanagerPluginInitialized();
  }

  WorkmanagerPluginInitialized() async {
    Workmanager().registerPeriodicTask(
      "periodic-task-identifier",
      "periodicTask",
      frequency: Duration(minutes: 15),
    );
  }

  void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      switch (task) {
        case "periodicTask":
          print("Task Called 15 Hrs");
          updateUserSound();
          break;
      }
      updateUserSound();
      return Future.value();
    });
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
      User user = auth.currentUser;
      if (user != null) {
        uid = user.uid;
      } else
        return;
      var prev = null;

      //get the previous average decibels of the user from Database
      firestore.collection("users").doc(uid).get().then((value) {
        var prev = value.data().containsKey("db");
      });

      //no db field in firestore as db
      if (prev == false)
        firestore.collection("users").doc(uid).update({
          "db": FieldValue.arrayUnion([_db])
        });

      //updte the latest average db of the user in the user details
      firestore.collection("users").doc(uid).update({
        "db": FieldValue.arrayUnion([_db])
      });
    });
  }

  getData() {
    return data;
  }
}
