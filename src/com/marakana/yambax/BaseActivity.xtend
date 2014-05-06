package com.marakana.yambax

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import android.widget.Toast


interface Command
{
  def void doCommand()
}
  
class BaseActivity extends Activity
{
  protected var YambaApplication app
 
  val prefs         = [ | startActivity(new Intent(this, typeof(PrefsActivity))
                                              .addFlags(Intent.FLAG_ACTIVITY_REORDER_TO_FRONT)) ] as Command
  
  val toggleService = [ | intent = new Intent(this, typeof(UpdaterService))
                          if (YambaApplication.serviceRunning)
                            stopService(intent)
                           else
                            startService(intent) 
                          YambaApplication.serviceRunning = !YambaApplication.serviceRunning] as Command
  
  val purge         = [ | app.clearTimeline
                          Toast.makeText(this, R.string.msgAllDataPurged, Toast.LENGTH_LONG).show() ] as Command
                         
  val timeline      = [ | startActivity(new Intent(this, typeof(TimelineActivity))
                                        .addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP)
                                        .addFlags(Intent.FLAG_ACTIVITY_REORDER_TO_FRONT)) ] as Command
 
  val status        = [ | startActivity(new Intent(this, typeof(StatusActivity))
                                        .addFlags(Intent.FLAG_ACTIVITY_REORDER_TO_FRONT))] as Command
  
  var commands      = #{ R.id.itemPrefs         -> prefs,
                         R.id.itemToggleService -> toggleService,
                         R.id.itemPurge         -> purge,
                         R.id.itemTimeline      -> timeline,
                         R.id.itemStatus        -> status  }
    
  override onCreate(Bundle savedInstanceState)
  {
    super.onCreate(savedInstanceState);
    app = getApplication as YambaApplication 
  }

  override onCreateOptionsMenu(Menu menu)
  { 
    getMenuInflater.inflate(R.menu.menu, menu)
    true
  }  
  
  override onOptionsItemSelected(MenuItem item)
  { 
    val command = commands.get(item.getItemId) as Command
    command.doCommand
    true
  } 
  
  override onMenuOpened(int featureId, Menu menu)
  { 
    val toggleItem = menu.findItem(R.id.itemToggleService)
    toggleItem.title = if (YambaApplication.serviceRunning) R.string.titleServiceStop         else R.string.titleServiceStart
    toggleItem.icon  = if (YambaApplication.serviceRunning) android.R.drawable.ic_media_pause else android.R.drawable.ic_media_play
    true
  }   
}
