import 'package:first_flutter_app/weather_forecast/model/weather_forecast_model.dart';
import 'package:first_flutter_app/weather_forecast/util/convert_icon.dart';
import 'package:first_flutter_app/weather_forecast/util/forecast_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget forecastCard(AsyncSnapshot<WeatherForecastModel> snapshot, int index) {
  var forecastList = snapshot.data.daily;
  var dayOfWeek = "";
  var time = new DateTime.fromMillisecondsSinceEpoch(forecastList[index].dt*1000);
  var fullDate = Util.getFormattedDate(time);
  dayOfWeek = fullDate.split(",")[0];

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Center(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(dayOfWeek),
      )),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 33,
            backgroundColor: Colors.white,
            child: getWeatherIcon(
              weatherDescription: forecastList[index].weather[0].main,
              color: Colors.pinkAccent,
              size: 45
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("${forecastList[index].temp.min.toStringAsFixed(0)}"),
                  ),
                  Icon(FontAwesomeIcons.solidArrowAltCircleDown, color: Colors.white)
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("${forecastList[index].temp.max.toStringAsFixed(0)}"),
                  ),
                  Icon(FontAwesomeIcons.solidArrowAltCircleUp, color: Colors.white)
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Hum: ${forecastList[index].humidity.toStringAsFixed(0)}%"),
                  ),
                  // Icon(FontAwesomeIcons.solidGrinBeamSweat, color: Colors.white)
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Win: ${forecastList[index].windSpeed.toStringAsFixed(1)} km/h"),
                  ),
                  // Icon(FontAwesomeIcons.wind, color: Colors.white)
                ],
              )
            ],
          )
        ],
      )
    ],
  );

}