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

interface TimelineUpdateListener
{
  def void timelineUpdate()
}
 
class YambaApplication extends Application
{
  @Property TwitterAPI             twitter        = new TwitterAPI("student", "password", "http://yamba.marakana.com/api")
  @Property boolean                serviceRunning = false
  @Property List<Twitter.Status>   timeline       = new LinkedList<Status>
  @Property TimelineUpdateListener updateListener

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
    updateListener?.timelineUpdate
  }
  
  def clearTimeline()
  {
    timeline.clear
    updateListener?.timelineUpdate
  }
}