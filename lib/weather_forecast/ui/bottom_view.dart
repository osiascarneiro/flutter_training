import 'package:first_flutter_app/weather_forecast/model/weather_forecast_model.dart';
import 'package:flutter/material.dart';

import 'forecast_card.dart';

Widget bottomView(AsyncSnapshot<WeatherForecastModel> snapshot, BuildContext context) {
  var forecastList = snapshot.data.daily;

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text("7-Day Weather Forecast".toUpperCase(), style: TextStyle(
        fontSize:  14,
        color: Colors.black87
      )),
      Container(
        height: 170,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => SizedBox(width: 8),
          itemCount: forecastList.length,
          itemBuilder: (context, index) => ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                width: MediaQuery.of(context).size.width/2,
                height: 160,
                child: forecastCard(snapshot, index),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF9661C3), Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight
                  )
                ),
              ),
            )
        ),
      )
    ],
  );
}