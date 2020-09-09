import 'package:first_flutter_app/weather_forecast/model/weather_forecast_model.dart';
import 'package:first_flutter_app/weather_forecast/util/convert_icon.dart';
import 'package:first_flutter_app/weather_forecast/util/forecast_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget midView(AsyncSnapshot<WeatherForecastModel> snapshot) {
  var forecastList = snapshot.data.daily;
  var formattedDate = new DateTime.fromMillisecondsSinceEpoch(snapshot.data.daily[0].dt * 1000);
  var forecast = forecastList[0];
  var midView = Container(
    child: Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Chicago Ilinois", style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 18
          ),),
          Text(Util.getFormattedDate(formattedDate), style: TextStyle(
            fontSize: 15
          ),),
          SizedBox(height: 10,),
          getWeatherIcon(weatherDescription: forecast.weather[0].main, color: Colors.pinkAccent, size: 198),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${forecast.temp.day.toStringAsFixed(0)}˚C ", style: TextStyle(
                  fontSize: 34
                ),),
                Text("${forecast.weather[0].description.toUpperCase()}")
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${forecast.windSpeed.toStringAsFixed(1)} km/h"),
                      Icon(FontAwesomeIcons.wind, size: 20, color: Colors.brown,)
                      // Icon(Icons.arrow_forward, size: 20, color: Colors.brown,)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${forecast.humidity.toStringAsFixed(0)}%"),
                      Icon(FontAwesomeIcons.solidGrinBeamSweat, size: 20, color: Colors.brown,)
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${forecast.temp.max}˚ C"),
                      Icon(FontAwesomeIcons.temperatureHigh, size: 20, color: Colors.brown,)
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );

  return midView;
}