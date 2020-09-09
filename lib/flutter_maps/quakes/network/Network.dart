import 'dart:convert';

import 'package:first_flutter_app/flutter_maps/quakes/model/quake.dart';
import 'package:http/http.dart';

class Network {

  Future<Quake> getAllQuakes() async {
    var url = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/2.5_day.geojson";

    final response = await get(url);
    if(response.statusCode == 200) {
      print("Quake data: ${response.body}");
      return Quake.fromJson(json.decode(response.body));
    } else {
      throw Exception("Error getting quakes");
    }
  }

}