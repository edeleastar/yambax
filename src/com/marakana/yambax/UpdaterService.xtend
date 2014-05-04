package com.marakana.yambax

import android.content.Intent
import java.util.List
import winterwell.jtwitter.Twitter;
import com.marakana.utils.TwitterAPI
import winterwell.jtwitter.TwitterException
import android.util.Log
import com.marakana.utils.BackgroundService
import android.content.ContentValues

class UpdaterService extends BackgroundService
{
  var TwitterAPI twitter
  var StatusData statusData
  var count = 0;
  
  override onBind(Intent intent)
  {
    null
  } 

  override onCreate()
  {
    super.onCreate
    var app = getApplication() as YambaApplication
    this.twitter = app.twitter
    statusData = new StatusData(this)
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
  
  override def void doBackgroundTask()
  {
    try
    {
      val values                         = new ContentValues
      val List<Twitter.Status> timeline  = twitter.getFriendsTimeline
      val long latestStatusCreatedAtTime = statusData.getLatestStatusCreatedAtTime
      count = 0;
      timeline.forEach[ values.put(StatusDataTypes.C_ID, getId)
                        val createdAt = getCreatedAt.getTime
                        values.put(StatusDataTypes.C_CREATED_AT, createdAt)
                        values.put(StatusDataTypes.C_TEXT, getText)
                        values.put(StatusDataTypes.C_USER, getUser.getName)
                        Log.d("YAMBA", "Got update with id " + getId + ". Saving")
                        statusData.insertOrIgnore(values)
                        count = if (latestStatusCreatedAtTime < createdAt) count + 1 else count   ]
                        
      Log.d("YAMBA", if (count > 0) "Got " + count + " status updates" else "No new status updates");
    }
    catch (TwitterException e)
    {
      Log.e("YAMBA", "Failed to connect to twitter service", e); 
    }
    catch (Exception e)    
    {
      Log.d("YAMBA", "Data base error: " + e.getMessage())
    }
  }

}