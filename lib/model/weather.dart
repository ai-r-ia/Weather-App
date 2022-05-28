import 'package:weather/model/city.dart';

class Weather {
  int temperature = 0;
  int maxTemp = 0;
  int feelsLike = 0;
  String weatherStateName = 'Loading...';
  int humidity = 0;
  int windSpeed = 0;
  int pressure = 0;
  DateTime currentDate = DateTime.now();
  int woeid = 20070458; // Where on Earth ID for Delhi(default city)
  String location = 'Delhi';

  Weather(
      {required this.location,
      required this.temperature,
      required this.windSpeed,
      required this.humidity,
      required this.feelsLike,
      required this.pressure,
      required this.currentDate,
      required this.weatherStateName,
      required this.maxTemp,
      l});

  Weather.fromJson(Map<String, dynamic> json) {
    location = json["name"];
    temperature = json["main"]["temp"];
    windSpeed = json["wind"]["speed"];
    pressure = json["main"]["pressure"];
    humidity = json["main"]["humidity"];
    feelsLike = json["main"]["feels_like"];
    maxTemp = json["main"]["temp_max"];
  }
}
