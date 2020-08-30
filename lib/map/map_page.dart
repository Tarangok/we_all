import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:user_location/user_location.dart';
import 'package:we_all/system/api.dart' as api;
// import 'package:we_all/system/api.dart';

Timer timer;

class MapPage extends StatefulWidget {
  MapPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapController mapController = MapController();
  UserLocationOptions userLocationOptions;
  List<Marker> _markers = [];
  List<Marker> _users_markers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // var a = api.get_locations();
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) {
      updateMarkers();
    });
    // print(a);
  }

  String users_location = null;
  void updateMarkers() {
    _users_markers.clear();
    print("UPDATE");
    api.get_locations().then((value) {
      users_location = value;
    });
    Map<String, dynamic> users = jsonDecode(users_location);
    setState(() {
      print(users);
      for (var user in users['users']) {
        Marker new_marker = new Marker(
          point: LatLng(user['lat'], user['lon']),
          width: 30.0,
          height: 30.0,
          builder: (ctx) => new Container(
            child: new Icon(Icons.location_on),
          ),
        );
        _users_markers.add(new_marker);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    userLocationOptions = UserLocationOptions(
      context: context,
      mapController: mapController,
      markers: _markers,
      zoomToCurrentLocationOnLoad: false,
      showMoveToCurrentLocationFloatingActionButton: true,
      updateMapLocationOnPositionChange: false,
      onLocationUpdate: (a) {
        api.send_location(a);
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(51.5, -0.09),
          zoom: 13.0,
          plugins: [
            UserLocationPlugin(),
          ],
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          MarkerLayerOptions(markers: _users_markers),
          userLocationOptions,
        ],
        mapController: mapController,
      ),
    );
  }
}
