import 'package:weather_app_two/Models/WeatherData.dart';

class ForecastData {
  final String cityName;
  final List<WeatherData> list;

  ForecastData({required this.cityName, required this.list});

  factory ForecastData.fromJson(Map<String, dynamic> json) {
    List<WeatherData> list = [];

    for (dynamic e in json['list']) {
      WeatherData w = WeatherData(
        date: DateTime.fromMillisecondsSinceEpoch(e['dt'] * 1000, isUtc: false),
        name: json['city']['name'],
        temp: e['main']['temp'].toDouble(),
        main: e['weather'][0]['main'],
        icon: e['weather'][0]['icon'],
      );
      list.add(w);
    }

    return ForecastData(
      cityName: json['city']['name'],
      list: list,
    );
  }
}
