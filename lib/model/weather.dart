import 'package:weather/model/city.dart';

class Weather {
  double temperature = 0;
  int maxTemp = 0;
  int feelsLike = 0;
  String weatherStateName = 'Loading...';
  int humidity = 0;
  int windSpeed = 0;
  int pressure = 0;
  DateTime currentDate = DateTime.now();
  int woeid = 20070458; // Where on Earth ID for Delhi(default city)
  String location = 'Delhi';
  // late String description;

  Weather({
    required this.location,
    required this.temperature,
    required this.windSpeed,
    required this.humidity,
    required this.feelsLike,
    required this.pressure,
    required this.currentDate,
    required this.weatherStateName,
    required this.maxTemp,
    //  this.description = " ";
  });

//error values
  Weather.fromJson(Map<String, dynamic> json) {
    location = json["name"] ?? "___";
    temperature = json["main"]?["temp"]?.toInt() ?? 0;
    windSpeed = json["wind"]?["speed"].toInt() ?? 0;
    pressure = json["main"]?["pressure"].toInt() ?? 0;
    humidity = json["main"]?["humidity"].toInt() ?? 0;
    feelsLike = json["main"]?["feels_like"].toInt() ?? 0;
    maxTemp = json["main"]?["temp_max"].toInt() ?? 0;
    // description = json["main"]?["description"]? "____";
  }
}
