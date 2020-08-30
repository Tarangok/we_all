import 'package:flutter/material.dart';


class UserLocationIcon extends StatefulWidget {
  UserLocationIcon({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _UserLocationIconState createState() => _UserLocationIconState();
}

class _UserLocationIconState extends State<UserLocationIcon> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Location Plugin")),
      body: Container(),
    );
  }
}
