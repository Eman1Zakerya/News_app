import 'package:shared_preferences/shared_preferences.dart';

class CashHelper
{
  static SharedPreferences? sharedPreferences;
  static init()async
  {
    sharedPreferences = await SharedPreferences.getInstance();
  }

   static Future<bool?> putBoolean({
    required String key,
    required bool value
  })async
  {
    return await sharedPreferences?.setBool(key, value);
  }

   static bool? getBoolean({
    required String key,
    
  })
  {
    return  sharedPreferences?.getBool(key );
  }
}


//d5ec87b167e74fb2a8f7687eb0b0d798
//https://newsapi.org/v2/everything?q=Apple&apiKey=d5ec87b167e74fb2a8f7687eb0b0d798
//https://newsapi.org/v2/everything?q=tesla&apiKey=d5ec87b167e74fb2a8f7687eb0b0d798