package com.marakana.yambax

import android.os.AsyncTask
import android.util.Log
import winterwell.jtwitter.TwitterException
import android.widget.Toast
import android.app.Activity
import com.marakana.utils.TwitterAPI
 
class TwitterPoster extends AsyncTask<String, Integer, String>
{
  var TwitterAPI twitter
  var Activity activity

  new(TwitterAPI twitter, Activity activity)
  {
    this.twitter = twitter
    this.activity = activity
  }

  override doInBackground(String... it)
  {
    try
    {
      var status = twitter.updateStatus(get(0))
      status
    }
    catch (TwitterException e)
    {
      Log.e("YAMBA", e.toString());
      "Failed to post";
    }
  }

  override onPostExecute(String result)
  {
    Toast.makeText(activity, result, Toast.LENGTH_LONG).show();
  }
}
