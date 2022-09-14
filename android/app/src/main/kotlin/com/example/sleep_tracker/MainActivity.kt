package com.example.sleep_tracker

import android.os.Bundle as Bundle
import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

        private val CHANNEL = "sleep_tracker/background_task"
        private var channel: MethodChannel? = null

        override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
                super.configureFlutterEngine(flutterEngine)

                // creating a new MethodChannel
                channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)

                //other way without using onCreate
        //     MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
        //         if(call.method == "methodName"){
        //             //DO THIS, method name is passed by FLUTTER code ie. methodChannel.invokeMethod('methodName'); 
        //         }
        //     }

        }

        override fun onCreate(savedInstanceState: Bundle?) {
                super.onCreate(savedInstanceState)


		//After 0ms this would be called
		Handler(Looper.getMainLooper()).postDelayed({
			//Create variable to pass the Data
			val result = "Native_Data"

			// call this method to call the Dart Code
			channel?.invokeMethod("background_task", result)
		},0)



		
        }
}