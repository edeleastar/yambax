package com.marakana.yambax

import android.app.Service
import android.content.Intent

class UpdaterService extends Service
{
  val DELAY   = 10000
  var running = false 
  var Thread updateThread
  
  var updater = [ | 
                  while (!Thread.currentThread().isInterrupted() && running)
                  {
                    try
                    {
                      Thread.sleep(DELAY);
                    }
                    catch (InterruptedException e)
                    {}
                  } ] as Runnable
  
  override onBind(Intent intent)
  {
  } 

  override onCreate()
  {
    updateThread = new Thread(updater)
    super.onCreate
  }

  override onStartCommand(Intent intent, int flags, int startId)
  {
    super.onStartCommand(intent, flags, startId)
    running = true
    updateThread.start
    START_STICKY;
  }

  override onDestroy()
  {
    super.onDestroy
    running = false
    updateThread.interrupt
  }
}
