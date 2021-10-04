

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper
{
  static SharedPreferences sharedPreferences;
  static init() async {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    static Future <bool> putBoolean({
      @required String key ,
      @required bool value,

      })async {
    return await sharedPreferences.setBool(key, value);

  }
    static  dynamic  getData({
       @required String key ,
    })
     {
    return sharedPreferences.get(key);
    }

    // static dynamic getData ({
    //   @required String key ,
    //      }
    // ){
    //   if(key is String) return  sharedPreferences.getString(key);
    //   if(key is int) return  sharedPreferences.getInt(key);
    //   if(key is bool) return  sharedPreferences.getBool(key);
    //   return  sharedPreferences.getDouble(key);
    // }
  static Future<bool> saveData({
  @required String key,
  @required dynamic value,
})async
  {
     if(value is String) return await sharedPreferences.setString(key, value);
     if(value is int) return await sharedPreferences.setInt(key, value);
     if(value is bool) return await sharedPreferences.setBool(key, value);
     return await sharedPreferences.setDouble(key, value);
  }

 static  Future<bool> removeData({@required String key , }) async {
  return await  sharedPreferences.remove(key);
  }
}
