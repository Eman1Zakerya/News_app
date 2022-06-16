import 'package:dio/dio.dart';

class DioHelper
{
  static  Dio? dio;

  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl:'https://newsapi.org/' ,
        receiveDataWhenStatusError: true
      )
    );
  }

  static Future<Response?> getData({
    required String url,required Map<String,dynamic> query
    })async
  {
    return await dio?.get(url,queryParameters:query );
  }
}















//api key (d5ec87b167e74fb2a8f7687eb0b0d798)
//https://newsapi.org/v2/everything?q=Apple&from=2022-04-28&sortBy=popularity&apiKey=d5ec87b167e74fb2a8f7687eb0b0d798
//https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=d5ec87b167e74fb2a8f7687eb0b0d798