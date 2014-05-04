package com.marakana.yambax

import com.marakana.utils.TwitterAPI
import android.content.SharedPreferences
import android.content.SharedPreferences.OnSharedPreferenceChangeListener
import android.app.Application
import android.preference.PreferenceManager

class YambaApplication extends Application
{
  @Property TwitterAPI twitter
  
  var prefsChanged = [ SharedPreferences prefs, String s|
                       twitter.changeAccount(prefs)  ]  as OnSharedPreferenceChangeListener
                                  
  override onCreate()
  {
    super.onCreate
    twitter = new TwitterAPI("student", "password", "http://yamba.marakana.com/api")
    PreferenceManager.getDefaultSharedPreferences(this).registerOnSharedPreferenceChangeListener = prefsChanged     
  }
  
  override onTerminate()
  {
    super.onTerminate
  }
}
