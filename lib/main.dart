import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_all/login/login_page.dart';
import 'package:we_all/map/map_page.dart';

void main() {
  runApp(MaterialApp(
    title: 'Named Routes Demo',
    initialRoute: '/',
    routes: {
      '/': (context) => LoginPage(),
      '/map': (context) => MapPage(
            title: "Map",
          ),
    },
  ));
}
