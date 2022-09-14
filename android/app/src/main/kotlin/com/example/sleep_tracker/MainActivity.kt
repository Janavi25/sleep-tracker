package com.example.sleep_tracker

import android.os.Bundle as Bundle
import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

//import androidx.appcompat.app.AppCompatActivity
//import android.os.Bundle
//import android.widget.TextView
import android.widget.Toast
import androidx.lifecycle.Observer
import androidx.work.*
import androidx.work.impl.model.WorkTypeConverters.StateIds.ENQUEUED
import java.util.concurrent.TimeUnit

class MainActivity : FlutterActivity() {

        private val CHANNEL = "sleep_tracker/background_task"
        private var channel: MethodChannel? = null
        val decibels : Double = 00.000


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


            //#updated 12:27 -jaimit25
//             val constraints = Constraints.Builder()
//                 .setRequiresBatteryNotLow(true)
//                 //.setRequiredNetworkType(NetworkType.CONNECTED)
//                 .build()

//             val data = Data.Builder()
//                 .putDouble("db",00.00)
//                 .build()

//             val periodicWorkRequest = PeriodicWorkRequestBuilder<Work>(15, TimeUnit.MINUTES).setConstraints(constraints).setInputData(data).build()
//             WorkManager.getInstance(this).enqueue(periodicWorkRequest)

//             //To get the data from doWork which was executed every 15 Minutes
//             WorkManager.getInstance()
//                 .getWorkInfoByIdLiveData(periodicWorkRequest.id).observe(this, Observer { workInfo ->
//                     val wasSuccess = if (workInfo != null && workInfo.state == WorkInfo.State.SUCCEEDED) {
//                         workInfo.outputData.getDouble("outputData", 00.000)
//                     } else {
//                         00.0000
//                     }
// //                txtV.text = wasSuccess.toString()
//                     Toast.makeText(this, "Work result : ${wasSuccess}", Toast.LENGTH_LONG).show()
//                 })
            //# END updated 12:27 -jaimit25
			channel?.invokeMethod("background_task", result.toString())


        },0)



		
        }
}