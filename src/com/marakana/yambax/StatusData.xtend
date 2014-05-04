package com.marakana.yambax

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;
import android.content.ContentValues
import android.database.Cursor

class StatusDataTypes
{
  public static final val VERSION  = 1
  public static final val DATABASE = "timeline.db"
  public static final val TABLE    = "timeline"

  public static final val C_ID         = "_id"
  public static final val C_CREATED_AT = "created_at"
  public static final val C_TEXT       = "txt"
  public static final val C_USER       = "user"
  
  public static final String GET_ALL_ORDER_BY = C_CREATED_AT + " DESC"
  public static final String[] MAX_CREATED_AT_COLUMNS = #{ "max(" + StatusDataTypes.C_CREATED_AT + ")" }
  public static final String[] DB_TEXT_COLUMNS = #{ C_TEXT }
}

class DbHelper extends SQLiteOpenHelper
{
  new (Context context)
  {
   super(context, StatusDataTypes.DATABASE, null, StatusDataTypes.VERSION)
  }

  override onCreate(SQLiteDatabase db)
  {
    Log.i("YAMBA", "Creating database: " + StatusDataTypes.DATABASE)
    db.execSQL("create table " + StatusDataTypes.TABLE + " (" + StatusDataTypes.C_ID + " int primary key, " + StatusDataTypes.C_CREATED_AT + " int, " + StatusDataTypes.C_USER + " text, " + StatusDataTypes.C_TEXT + " text)");
  }

  override onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion)
  {
    db.execSQL("drop table " + StatusDataTypes.TABLE)
    this.onCreate(db)
  }
 }

class StatusData
{
  val DbHelper dbHelper

  new (Context context)
  { 
    this.dbHelper = new DbHelper(context);
  }

  def void close()
  { 
    this.dbHelper.close()
  }

  def void insertOrIgnore(ContentValues values)
  { 
    val db = this.dbHelper.getWritableDatabase(); 
    try
    {
      db.insertWithOnConflict(StatusDataTypes.TABLE, null, values, SQLiteDatabase.CONFLICT_IGNORE); 
    }
    finally
    {
      db.close(); 
    }
  }
  
  def Cursor getStatusUpdates()
  { 
    val SQLiteDatabase db = this.dbHelper.getReadableDatabase();
    return db.query(StatusDataTypes.TABLE, null, null, null, null, null, StatusDataTypes.GET_ALL_ORDER_BY);
  }
 
  def long getLatestStatusCreatedAtTime()
  { 
    val SQLiteDatabase db = this.dbHelper.getReadableDatabase();
    try
    {
      val Cursor cursor = db.query(StatusDataTypes.TABLE, StatusDataTypes.MAX_CREATED_AT_COLUMNS, null, null, null, null, null);
      try
      {
        return if (cursor.moveToNext()) cursor.getLong(0) else Long.MIN_VALUE;
      }
      finally
      {
        cursor.close();
      }
    }
    finally
    {
      db.close();
    }
  }

 def  String getStatusTextById(long id)
  { 
    val SQLiteDatabase db = this.dbHelper.getReadableDatabase();
    try
    {
      val Cursor cursor = db.query(StatusDataTypes.TABLE, StatusDataTypes.DB_TEXT_COLUMNS, StatusDataTypes.C_ID + "=" + id, null, null, null, null);
      try
      {
        return if (cursor.moveToNext()) cursor.getString(0) else null;
      }
      finally
      {
        cursor.close();
      }
    }
    finally
    {
      db.close();
    }
  } 
}