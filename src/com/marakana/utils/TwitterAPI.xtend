package com.marakana.utils

import winterwell.jtwitter.Twitter

class TwitterAPI
{
  var Twitter twitter

  new ()
  {
    this.twitter = new Twitter("student", "password")
    twitter.setAPIRootUrl("http://yamba.marakana.com/api")
  }
   
  def String updateStatus (String status)
  { 
    val result = twitter.updateStatus(status)
    result.text
  }
}
