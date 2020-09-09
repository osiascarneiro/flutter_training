import 'package:first_flutter_app/weather_forecast/model/weather_forecast_model.dart';
import 'package:first_flutter_app/weather_forecast/util/convert_icon.dart';
import 'package:first_flutter_app/weather_forecast/util/forecast_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MidView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecastModel> snapshot;

  const MidView({Key key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data.daily;
    var formattedDate = new DateTime.fromMillisecondsSinceEpoch(snapshot.data.daily[0].dt * 1000);
    var forecast = forecastList[0];

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: getWeatherIcon(weatherDescription: forecast.weather[0].main, color: Colors.pinkAccent, size: 198),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
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
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
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
                        Text("${forecast.temp.max.toStringAsFixed(0)}˚ C"),
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
  }
}