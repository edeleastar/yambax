package com.marakana.yambax

import android.os.Bundle
import android.widget.ListView
import android.widget.ArrayAdapter
import winterwell.jtwitter.Twitter
import android.content.Context
import java.util.List
import winterwell.jtwitter.Twitter.Status
import android.view.View
import android.view.ViewGroup
import android.view.LayoutInflater
import android.widget.TextView
import java.text.DateFormat
import java.text.SimpleDateFormat

class TimelineActivity extends BaseActivity
{
  var TimelineAdapter timelineAdapter
  var timelineUpdate = [| timelineAdapter.notifyDataSetChanged ] as TimelineUpdateListener
  
  override onCreate(Bundle savedInstanceState)
  {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.timeline)
    timelineAdapter    = new TimelineAdapter(this, R.layout.row, app.timeline)
    app.updateListener = timelineUpdate
  }
   
  override onStart()
  { 
    super.onStart    
    val listTimeline = findViewById(R.id.listTimeline) as ListView
    listTimeline.setAdapter(timelineAdapter);
  }
}

class StatusAdapter
{
  @Property View view;
  var DateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
  
  new (Context context, ViewGroup parent, Twitter.Status status)
  {
    val LayoutInflater inflater = context.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
    view = inflater.inflate(R.layout.row, parent, false)    
    view.id = status.id.intValue
    updateControls(status)
  }
  
  def updateControls(Twitter.Status status)
  {
    val user       = view.findViewById(R.id.textUser)      as TextView
    val createdAt  = view.findViewById(R.id.textCreatedAt) as TextView
    val text       = view.findViewById(R.id.textText)      as TextView 
    
    user.text      = status.getUser.name
    createdAt.text = df.format(status.createdAt)
    text.text      = status.text
  }
}

class TimelineAdapter extends ArrayAdapter<Twitter.Status>
{
  var List<Status> timeline
  var Context      context
  
  new(Context context, int textViewResourceId, List<Twitter.Status> timeline) 
  {
    super(context, textViewResourceId, timeline)
    this.timeline = timeline
    this.context  = context
  }
  
  override getView(int position, View convertView, ViewGroup parent)
  {
    val status = timeline.get(position)
    val item = new StatusAdapter (context, parent, status)
    return item.view
  }
  
  override getCount()
  {
    return timeline.size
  }

  override Twitter.Status getItem(int position)
  {
    return timeline.get(position);
  }

  override getItemId(int position)
  {
    val status = timeline.get(position);
    status.id;
  }

  override getPosition(Twitter.Status c)
  {
    return timeline.indexOf(c);
  }  
}
