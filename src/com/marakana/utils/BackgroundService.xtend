package com.marakana.utils

import android.app.Service
import android.content.Intent

abstract class BackgroundService extends Service
{
  val DELAY   = 10000
  var running = false 
  var Thread updateThread
  
  var updater = [ | 
                  while (!Thread.currentThread().isInterrupted() && running)
                  {
                    try
                    {
                      this.doBackgroundTask()
                      Thread.sleep(DELAY);
                    }
                    catch (InterruptedException e)
                    {}
                  } ] as Runnable
  
  override onBind(Intent intent)
  {
    null
  } 

  def abstract void doBackgroundTask()
  
  def startBackgroundTask()
  {
    running = true
    updateThread.start
  }
  
  def stopBackgroundTask()
  {
    running = false
    updateThread.interrupt
  }
  
  override onCreate()
  {
    updateThread = new Thread(updater)
    super.onCreate
  }
}