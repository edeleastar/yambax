package com.marakana.yambax

import android.app.Service
import android.content.Intent
import java.util.List
import winterwell.jtwitter.Twitter;
import com.marakana.utils.TwitterAPI
import winterwell.jtwitter.TwitterException
import android.util.Log

class UpdaterService extends Service
{
  val DELAY   = 10000
  var running = false
   
  var Thread               updateThread
  var TwitterAPI           twitter
  var List<Twitter.Status> timeline;
  
  var updater = [ | 
                  while (!Thread.currentThread().isInterrupted() && running)
                  {
                    try
                    {
                      timeline = twitter.getFriendsTimeline()
                      timeline.forEach[ Log.d("YAMBA", String.format("%s: %s", it.user.name, it.text)); ]
                      Thread.sleep(DELAY);
                    }
                    catch (TwitterException e)
                    {
                      Log.e("YAMBA", "Failed to connect to twitter service", e); 
                    }
                    catch (InterruptedException e)
                    {}
                  } ] as Runnable
  
  override onBind(Intent intent)
  {
    null
  } 

  override onCreate()
  {
    var app = getApplication() as YambaApplication
    this.twitter = app.twitter
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
