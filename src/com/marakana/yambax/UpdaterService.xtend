package com.marakana.yambax

import android.content.Intent
import java.util.List
import winterwell.jtwitter.Twitter
import winterwell.jtwitter.Twitter.Status
import com.marakana.utils.TwitterAPI
import winterwell.jtwitter.TwitterException
import android.util.Log
import com.marakana.utils.BackgroundService
 
class UpdaterService extends BackgroundService
{
  public static final String NEW_STATUS_INTENT              = "com.marakana.yamba.NEW_STATUS"
  public static final String SEND_TIMELINE_NOTIFICATIONS    = "com.marakana.yamba.SEND_TIMELINE_NOTIFICATIONS";
  public static final String RECEIVE_TIMELINE_NOTIFICATIONS = "com.marakana.yamba.RECEIVE_TIMELINE_NOTIFICATIONS"
  
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
      
      app.updateTimeline(newTweets)
      sendBroadcast(new Intent(NEW_STATUS_INTENT), RECEIVE_TIMELINE_NOTIFICATIONS);      
      
    }
    catch (TwitterException e)
    {
      Log.e("YAMBA", "Failed to connect to twitter service", e); 
    }
  }
}
