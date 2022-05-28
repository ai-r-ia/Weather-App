import 'dart:convert';
import 'package:weather/model/weather.dart';
import 'package:http/http.dart' as http;

class WeatherApiClient {
  Future<Weather>? getCurrentWeather(String? location) async {
    var endpoint = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=1a0f712be220241be99f7df189b151e1&units=metric");
    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    print(body);
    return Weather.fromJson(body);
  }
}
