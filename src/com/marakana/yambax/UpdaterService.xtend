package com.marakana.yambax

import android.content.Intent
import java.util.List
import winterwell.jtwitter.Twitter
import winterwell.jtwitter.Twitter.Status
import com.marakana.utils.TwitterAPI
import winterwell.jtwitter.TwitterException
import android.util.Log
import com.marakana.utils.BackgroundService
import android.os.Looper
import android.os.Handler

class UpdaterService extends BackgroundService
{
  var YambaApplication app
  var TwitterAPI       twitter
  var Iterable<Status> newTweets 

  override onCreate()
  {
    super.onCreate
    app        = getApplication as YambaApplication
    twitter    = app.twitter
  }

  override onStartCommand(Intent intent, int flags, int startId)
  {
    super.onStartCommand(intent, flags, startId)
    startBackgroundTask
    app.serviceRunning = true
    START_STICKY;
  }

  override onDestroy()
  {
    super.onDestroy
    stopBackgroundTask
    app.serviceRunning = false
  }
  
  override def void doBackgroundTask()
  {
    try
    {
      val List<Twitter.Status> timeline  = twitter.getFriendsTimeline
      newTweets = if (app.timeline.size == 0) timeline else timeline.filter [it.id > app.timeline.get(0).id]

      Log.e("YAMBA", "number of new tweets= " + newTweets.size)       
      val handler = new Handler(Looper.getMainLooper)      
      
      handler.post ([| app.updateTimeline(newTweets)])
    }
    catch (TwitterException e)
    {
      Log.e("YAMBA", "Failed to connect to twitter service", e); 
    }
  }

}
