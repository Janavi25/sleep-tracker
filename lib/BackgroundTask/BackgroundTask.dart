import 'package:flutter/services.dart';

class BackgroundTask {
  //Declaring the method Channel
  var bg_channel = MethodChannel("sleep_tracker/background_task");

  var data;

  //Constructor
  BackgroundTask() {
    CallNativeAndReturnCallBackDart();
  }

  CallNativeAndReturnCallBackDart() {
    bg_channel.setMethodCallHandler((call) async {
      if (call.method == "background_task") {
        final data = call.arguments;
        print("Native Data passed (print:flutter) :: " + "${data.toString()}");
      }
    });
  }

  getData() {
    return data;
  }
}
