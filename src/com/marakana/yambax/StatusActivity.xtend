package com.marakana.yambax

import android.app.Activity
import android.os.Bundle
import android.widget.EditText
import android.widget.Button
import android.util.Log
import com.marakana.utils.TwitterAPI
import android.view.Menu
import android.view.MenuItem
import android.content.Intent

class StatusActivity extends Activity
{
  val twitter = new TwitterAPI

  override onCreate(Bundle savedInstanceState)
  {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity_status)
    
    val editText     = findViewById(R.id.editText) as EditText
    val updateButton =  findViewById(R.id.buttonUpdate) as Button
    
    updateButton.setOnClickListener = [ 
    	                                val twitterPoster = new TwitterPoster(twitter, this)
                                        twitterPoster.execute(editText.getText().toString())
                                        Log.d("YAMBA", "onClicked") 
                                      ]
  }
  
  override  onCreateOptionsMenu(Menu menu)
  {
    getMenuInflater.inflate(R.menu.menu, menu)
    true
  }
  
   override onOptionsItemSelected(MenuItem item)
  {
  	startActivity(new Intent(this, typeof(PrefsActivity)))
    true
  }
}