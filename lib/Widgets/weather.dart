import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:weather_app_two/Models/WeatherData.dart';

class Weather extends StatelessWidget {
  final WeatherData weather;

  const Weather({ Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(weather.name, style:const  TextStyle(color: Colors.white)),
        Text(weather.main, style: const TextStyle(color: Colors.white, fontSize: 32.0)),
        Text('${weather.temp.toString()}°F',  style: const TextStyle(color: Colors.white)),
        Image.network('https://openweathermap.org/img/w/${weather.icon}.png'),
        Text(DateFormat.yMMMd().format(weather.date), style: const TextStyle(color: Colors.white)),
        Text( DateFormat.Hm().format(weather.date), style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}