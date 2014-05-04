package com.marakana.utils

import winterwell.jtwitter.Twitter
import android.content.SharedPreferences

class TwitterAPI
{
  var Twitter twitter
 
  new (String username, String password, String root)
  {
    this.twitter = new Twitter(username, password)
    twitter.setAPIRootUrl(root)
  }
  
  def changeAccount(SharedPreferences prefs)
  {
  	val username = prefs.getString("username", "student")
  	val password = prefs.getString("password", "password")
  	val root     = prefs.getString("apiRoot", "http://yamba.marakana.com/api")
  	this.twitter = new Twitter(username, password)
    twitter.setAPIRootUrl(root)
  }
   
  def String updateStatus (String status)
  { 
    val result = twitter.updateStatus(status)
    result.text
  }
  
  def getFriendsTimeline()
  {
    return twitter.getFriendsTimeline()
  }
}