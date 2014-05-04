package com.marakana.yambax

import android.app.Service
import android.content.Intent

class UpdaterService extends Service
{
  override onBind(Intent intent)
  {
  }

  override onCreate()
  { 
    super.onCreate
  }

  override onStartCommand(Intent intent, int flags, int startId)
  { 
    super.onStartCommand(intent, flags, startId)
    START_STICKY;
  }

  override onDestroy()
  { 
    super.onDestroy
  }
}
