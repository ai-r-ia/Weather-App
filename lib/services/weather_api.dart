import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:weather/model/weather.dart';
import 'package:http/http.dart' as http;

class WeatherApiClient {
  Future<Weather> getCurrentWeather(String location) async {
    var endpoint = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=1a0f712be220241be99f7df189b151e1&units=metric");
    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    // print(body);
    return Weather.fromJson(body);
  }

//use code if API key for 16 day forecast is available on openweathermap.org

  // static Future<List> getWeekList(String location) async {
  //   final response = await http.get(Uri.parse(
  //       "https://api.openweathermap.org/data/2.5/forecast/daily?q=$location&units=metric&cnt=7&appid={API key}&units=metric"));
  //   String responseBody = "[${response.body}]";
  //   dynamic jsonObject = json.decode(responseBody) as List<dynamic>;
  //   List<Weather> list =
  //       jsonObject.map<Weather>((json) => Weather.fromJson(json)).toList();
  //   print(list);
  //   return list;
  // }
}
