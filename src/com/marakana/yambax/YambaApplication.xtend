package com.marakana.yambax

import com.marakana.utils.TwitterAPI
import android.content.SharedPreferences
import android.content.SharedPreferences.OnSharedPreferenceChangeListener
import android.app.Application
import android.preference.PreferenceManager
import java.util.List
import winterwell.jtwitter.Twitter;
import winterwell.jtwitter.Twitter.Status;
import java.util.LinkedList
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.net.ConnectivityManager
import android.util.Log

class NetworkReceiver extends BroadcastReceiver 
{ 
  override onReceive(Context context, Intent intent) 
  {
    val isNetworkDown = intent.getBooleanExtra(ConnectivityManager.EXTRA_NO_CONNECTIVITY, false); 
    
    if (isNetworkDown) 
    {
      if (YambaApplication.serviceRunning)
      {
        Log.d("YAMBA", "onReceive: NOT connected, stopping UpdaterService");
        context.stopService(new Intent(context, typeof(UpdaterService)))
      }
    }
    else 
    {
      if (!YambaApplication.serviceRunning)
      {
        Log.d("YAMBA", "onReceive: connected, starting UpdaterService");
        context.startService(new Intent(context, typeof(UpdaterService)))
      }
    }
  }
}

class BootReceiver extends BroadcastReceiver
{
  override onReceive(Context context, Intent intent) 
  {
    context.startService(new Intent(context, typeof(UpdaterService)))
  }
} 
 
class YambaApplication extends Application
{
  public static boolean            serviceRunning = false
  @Property TwitterAPI             twitter        = new TwitterAPI("student", "password", "http://yamba.marakana.com/api")
  @Property List<Twitter.Status>   timeline       = new LinkedList<Status>

  var prefsChanged = [ SharedPreferences prefs, String s |
                       twitter.changeAccount(prefs)  ]  as OnSharedPreferenceChangeListener
                                  
  override onCreate()
  {
    super.onCreate
    val prefs = PreferenceManager.getDefaultSharedPreferences(this)
    prefs.registerOnSharedPreferenceChangeListener = prefsChanged    
  }
  
  override onTerminate()
  {
    super.onTerminate
  }
  
  def updateTimeline(Iterable<Twitter.Status> newTweets)
  {
    newTweets.forEach[timeline.add(0, it)]
  }
  
  def clearTimeline()
  {
    timeline.clear
  }
}