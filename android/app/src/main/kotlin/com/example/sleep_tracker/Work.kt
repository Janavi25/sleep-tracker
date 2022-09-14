package com.example.workmanager
//https://flexiple.com/android/android-workmanager-tutorial-getting-started/
import android.content.Context
import android.util.Log
import androidx.work.Worker
import androidx.work.WorkerParameters
import androidx.work.workDataOf
import java.io.DataOutput

class Work(context: Context, workerParams: WorkerParameters) : Worker(context, workerParams) {

    override fun doWork(): Result {
        task_perform()
        //.. Data receiver from the MainActivity
        val decibels =  inputData.getDouble("db", 00.000)

        val res = task_perform()
        val data = workDataOf("outputData" to res) //key ->  outputData and pair-> res

        return Result.success(data)
    }

    fun task_perform() : Double{
        Log.e("WORKER","*** This is called only once in 15 Minutes ***")
        return 60.000
    }


}