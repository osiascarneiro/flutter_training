import 'dart:convert';

import 'package:first_flutter_app/weather_forecast/model/weather_forecast_model.dart';
import 'package:first_flutter_app/weather_forecast/util/forecast_util.dart';
import 'package:http/http.dart';

class Network {
  Future<WeatherForecastModel> getWeatherForecast({String cityName}) async {
    var finalUrl = "https://api.openweathermap.org/data/2.5/onecall?lat=33.441792&lon=-94.037689&exclude=current,minutely,hourly&APPID=${Util.appId}&units=metric";

    final response = await get(Uri.encodeFull(finalUrl));
    print("URL: ${Uri.encodeFull(finalUrl)}");

    if(response.statusCode == 200) {
      try {
        var object = WeatherForecastModel.fromJson(json.decode(response.body));
        return object;
      } catch(e) {
        print("Error! ${e.toString()}");
        throw e;
      }
    } else {
      throw Exception("Error getting weather forecast");
    }
  }
}