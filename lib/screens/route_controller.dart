import 'package:churchapp/registration/login_screen.dart';
import 'package:churchapp/screens/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LoginStatus { notSignIn, signIn }

class RouteController extends StatefulWidget {
  @override
  _RouteControllerState createState() => _RouteControllerState();
}

class _RouteControllerState extends State<RouteController> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  BuildContext _ctx;
  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        _ctx = context;
        return LoginScreen();
        break;
      case LoginStatus.signIn:
        return MyNavBar();
        break;
    }
  }
}
