package com.marakana.yambax

import android.app.Activity
import android.os.Bundle
import android.widget.EditText
import android.widget.Button
import android.util.Log
import com.marakana.utils.TwitterAPI

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
}