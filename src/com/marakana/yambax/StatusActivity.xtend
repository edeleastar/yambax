package com.marakana.yambax

import android.app.Activity
import android.os.Bundle
import android.widget.EditText
import android.widget.Button
import android.view.View.OnClickListener
import android.view.View
import winterwell.jtwitter.Twitter
import android.util.Log
import android.os.StrictMode

class StatusActivity extends Activity implements OnClickListener
{
  val TAG = "StatusActivity"
  var EditText editText
  var Button updateButton
  var twitter = new Twitter("student", "password")

  override onCreate(Bundle savedInstanceState)
  {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity_status)
    
    val policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
    StrictMode.setThreadPolicy(policy);
    
    editText     = findViewById(R.id.editText) as EditText
    updateButton =  findViewById(R.id.buttonUpdate) as Button
    
    updateButton.setOnClickListener(this)

    twitter.setAPIRootUrl("http://yamba.marakana.com/api")
  }

  override onClick(View arg0)
  {
  	twitter.setStatus(editText.getText.toString)
    Log.d(TAG, "onClicked")
  }
}