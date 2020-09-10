import 'dart:async';

import 'package:first_flutter_app/flutter_maps/quakes/network/Network.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'model/quake.dart';

class QuakesApp extends StatefulWidget {
  @override
  _QuakesAppState createState() => _QuakesAppState();
}

class _QuakesAppState extends State<QuakesApp> {
  Future<Quake> quakesData;
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> _markerList = [];
  double _zoomVal = 5.0;

  @override
  void initState() {
    super.initState();
    quakesData = Network().getAllQuakes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildGoogleMap(context),
          _zoomMinus(),
          _zoomPlus()
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: findQuakes, label: Text("Find Quakes")),
    );
  }

  Widget _zoomPlus() {
    return Padding(
      padding: const EdgeInsets.only(top: 38),
      child: Align(
        alignment: Alignment.topRight,
        child: IconButton(
          onPressed: () {
            _zoomVal++;
            _plus(_zoomVal);
          },
          icon: Icon(FontAwesomeIcons.searchPlus),
        ),
      ),
    );
  }

  Widget _zoomMinus() {
    return Padding(
      padding: const EdgeInsets.only(top: 38.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          onPressed: () {
            _zoomVal--;
            _minus(_zoomVal);
          },
          icon: Icon(FontAwesomeIcons.searchMinus),
        ),
      ),
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: GoogleMap(
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        initialCameraPosition: CameraPosition(target: LatLng(36.1083333, -117.8608333), zoom: _zoomVal),
        markers: Set<Marker>.of(_markerList),
      ),
    );
  }

  void findQuakes() {
    setState(() {
      _markerList.clear();
      _handleResponse();
    });
  }

  void _handleResponse() {
    setState(() {
      quakesData.then((quakes) => {
        quakes.features.forEach((quake) {
          _markerList.add(Marker(
            markerId: MarkerId(quake.id),
            infoWindow: InfoWindow(title: quake.properties.mag.toString(), snippet: quake.properties.title),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
            position: LatLng(quake.geometry.coordinates[1], quake.geometry.coordinates[0]),
            onTap: () {}
          ));
        })
      });
    });
  }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(40.712776, -74.005974),
      zoom: zoomVal
    )));
  }

  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(40.712776, -74.005974),
        zoom: zoomVal
    )));
  }
}
