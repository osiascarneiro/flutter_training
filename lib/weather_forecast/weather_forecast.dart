import 'package:first_flutter_app/weather_forecast/model/weather_forecast_model.dart';
import 'package:first_flutter_app/weather_forecast/ui/bottom_view.dart';
import 'package:flutter/material.dart';

import 'network/Network.dart';
import 'ui/mid_view.dart';

class WeatherForecast extends StatefulWidget {
  @override
  _WeatherForecastState createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {

  Future<WeatherForecastModel> forecastObject;
  String _cityName = "Mumbai";

  @override
  void initState() {
    super.initState();
    forecastObject = getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          textFieldView(),
          Container(
            child: FutureBuilder<WeatherForecastModel>(
              future: forecastObject,
              builder: (BuildContext context, AsyncSnapshot<WeatherForecastModel> snapshot) {
                if(snapshot.hasData) {
                  return Column(
                    children: [
                      midView(snapshot),
                      bottomView(snapshot, context)
                    ],
                  );
                } else {
                  return Container(child: Center(child: CircularProgressIndicator()));
                }
              },
            ),
          )
        ],
      )
    );
  }

  Widget textFieldView() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          decoration: InputDecoration(
            hintText: "Enter city name",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            contentPadding: EdgeInsets.all(8)
          ),
          onSubmitted: (value) {
            setState(() {
              _cityName = value;
              forecastObject = getWeather();
            });
          },
        ),
      ),
    );
  }

  Future<WeatherForecastModel> getWeather() => new Network().getWeatherForecast(cityName: _cityName);
}
