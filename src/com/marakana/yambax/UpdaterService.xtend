package com.marakana.yambax

import android.content.Intent
import java.util.List
import winterwell.jtwitter.Twitter;
import com.marakana.utils.TwitterAPI
import winterwell.jtwitter.TwitterException
import android.util.Log
import com.marakana.utils.BackgroundService

class UpdaterService extends BackgroundService
{
  var TwitterAPI           twitter
  var List<Twitter.Status> timeline;
  
  override onBind(Intent intent)
  {
    null
  } 

  override def void doBackgroundTask()
  {
    try
    {
      timeline = twitter.getFriendsTimeline()
      timeline.forEach[ Log.d("YAMBA", String.format("%s: %s", it.user.name, it.text))]
    }
    catch (TwitterException e)
    {
      Log.e("YAMBA", "Failed to connect to twitter service", e); 
    }
  }
  
  override onCreate()
  {
    super.onCreate
    var app = getApplication() as YambaApplication
    this.twitter = app.twitter
  }

  override onStartCommand(Intent intent, int flags, int startId)
  {
    super.onStartCommand(intent, flags, startId)
    startBackgroundTask
    START_STICKY;
  }

  override onDestroy()
  {
    super.onDestroy
    stopBackgroundTask
  }
}