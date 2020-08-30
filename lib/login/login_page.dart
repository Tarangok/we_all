import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:we_all/map/map_page.dart';
import 'package:we_all/system/api.dart' as api;

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginPage extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);
  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'Username not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'We All',
      emailValidator: (value) {
        return null;
      },
      // logo: 'assets/images/ecorp-lightblue.png',
      onLogin: api.login_user,
      onSignup: api.register_user,
      onSubmitAnimationCompleted: () {
        Navigator.pushNamed(context, '/map');
      },
      onRecoverPassword: api.recover_password,
    );
  }
}
