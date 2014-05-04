package com.marakana.yambax

import android.os.Bundle
import android.widget.EditText
import android.widget.Button
import android.view.View.OnClickListener

class StatusActivity extends  BaseActivity 
{
  var EditText       editText
  var Button         updateButton
  var update       = [ new TwitterPoster(this).execute(editText.getText.toString)  ] as OnClickListener

  override onCreate(Bundle savedInstanceState)
  {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity_status)
        
    editText     = findViewById(R.id.editText) as EditText
    updateButton = findViewById(R.id.buttonUpdate) as Button
    
    updateButton.setOnClickListener = update   
  }
}