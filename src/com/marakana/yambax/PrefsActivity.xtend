package com.marakana.yambax

import android.os.Bundle
import android.preference.PreferenceActivity;

class PrefsActivity extends PreferenceActivity 
{
  override onCreate(Bundle savedInstanceState)
  {
    super.onCreate(savedInstanceState);
    addPreferencesFromResource(R.xml.prefs); 
  }  
}