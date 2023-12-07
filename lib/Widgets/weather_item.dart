import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the 'intl' package for date formatting
import '../Models/WeatherData.dart';

class WeatherItem extends StatelessWidget {
  final WeatherData weather;

  const WeatherItem({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(weather.name, style:const TextStyle(color: Colors.black)),
            Text(weather.main, style:const TextStyle(color: Colors.black, fontSize: 24.0)),
            Text('${weather.temp.toString()}°F', style:const TextStyle(color: Colors.black)),
            Image.network('https://openweathermap.org/img/w/${weather.icon}.png'),
            Text(DateFormat.yMMMd().format(weather.date), style:const TextStyle(color: Colors.black)),
            Text(DateFormat.Hm().format(weather.date), style:const TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
