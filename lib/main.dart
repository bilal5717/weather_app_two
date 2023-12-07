import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app_two/Widgets/weather.dart';
import 'package:weather_app_two/Widgets/weather_item.dart';
import 'package:weather_app_two/Models/WeatherData.dart';
import 'package:weather_app_two/Models/ForecastData.dart';
import 'package:location/location.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  bool isLoading = false;
  WeatherData? weatherData;
  ForecastData? forecastData;
  Location location = Location();

  @override
  void initState() {
    super.initState();
    weatherData = WeatherData(
      date: DateTime.now(),
      name: '',
      temp: 0.0,
      main: '',
      icon: '',
    );
    forecastData = ForecastData(cityName: '', list: []);
    loadWeather();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        backgroundColor: Colors.cyan,

        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: Container(
                  width: 50.0,
                  height:50.0,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(16.0)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: weatherData != null
                            ? Weather(weather: weatherData!)
                            : Container(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: isLoading
                            ? CircularProgressIndicator(
                          strokeWidth: 2.0,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        )
                            : IconButton(
                          icon: Icon(Icons.refresh),
                          tooltip: 'Refresh',
                          onPressed: loadWeather,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200.0,
                    child: forecastData != null
                        ? ListView.builder(
                      itemCount: forecastData!.list.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          WeatherItem(weather: forecastData!.list[index]),
                    )
                        : Container(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loadWeather() async {
    setState(() {
      isLoading = true;
    });

    try {
      LocationData currentLocation = await location.getLocation();
      final lat = currentLocation.latitude;
      final lon = currentLocation.longitude;
      final apiKey = '2f4cce040b346fed08232af39ccd263f';

      final weatherResponse = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/weather?APPID=$apiKey&lat=${lat.toString()}&lon=${lon.toString()}'),
      );

      final forecastResponse = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?APPID=$apiKey&lat=${lat.toString()}&lon=${lon.toString()}'),
      );

      if (weatherResponse.statusCode == 200 &&
          forecastResponse.statusCode == 200) {
        setState(() {
          weatherData =
              WeatherData.fromJson(jsonDecode(weatherResponse.body));
          forecastData =
              ForecastData.fromJson(jsonDecode(forecastResponse.body));
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }
}
