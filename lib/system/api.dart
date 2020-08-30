import 'dart:convert';

import 'package:flutter_login/flutter_login.dart';
import 'package:latlong/latlong.dart';
import 'package:http/http.dart' as http;

Duration loginTime = new Duration(milliseconds: 2250);
String user_token = null;

int send_location(LatLng latlong) {
  http
      .get(
          'https://we-all.tarangok.ru/api/test.php?lat=${latlong.latitude}&lon=${latlong.longitude}&token=$user_token')
      .then((response) {
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");
  }).catchError((error) {
    print("Error: $error");
  });

  return 0;
}

Future<String> login_user(LoginData data) async {
  var response = await http.post('https://we-all.tarangok.ru/api/login.php',
      body: {'form_email': data.name, 'password': data.password});
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  Map<String, dynamic> resp = jsonDecode(response.body);
  // print(resp);
  return Future.delayed(loginTime).then((value) {
    if (resp['response'] == "OK") {
      user_token = resp['token'];
      return null;
    } else {
      return response.body;
    }
  });
}

Future<String> register_user(LoginData data) async {
  var response = await http.post('https://we-all.tarangok.ru/api/register.php',
      body: {'form_email': data.name, 'form_pwd': data.password});
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  Map<String, dynamic> resp = jsonDecode(response.body);
  return Future.delayed(loginTime).then((value) {
    if (resp['response'] == "OK") {
      user_token = resp['token'];
      return null;
    } else {
      return resp['response'];
    }
  });
}

Future<String> recover_password(String data) {
  return Future.delayed(loginTime).then((value) {
    return 'Ok';
  });
}

Future<String> get_locations() async {
  var resp;
  var response = await http
      .get('https://we-all.tarangok.ru/api/get_locations.php?token=$user_token')
      .then((response) {
    // print("Response status: ${response.statusCode}");
    // print("Response body: ${response.body}");
    resp = response.body;
  });
  return resp;
}
