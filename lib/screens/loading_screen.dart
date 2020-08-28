import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'route_controller.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  var churchName = "DELIVERANCE CHURCH UTAWALA";
  var slogan = 'The Church of Choice';
  final Color primaryColor = Color(0xff18203d);
  @override
  void initState() {
    // implement initState
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RouteController()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        image: AssetImage('assets/images/dcu-logo.png'),
                        height: 80.0,
                        width: 80.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Center(
                        child: Text(
                          '$churchName',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                flex: 2,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            //.............................................progressive indicator
                            Visibility(
                                visible: true,
                                child: Container(
                                  child: SpinKitFadingCube(
                                    color: Colors.white,
                                    size: 25.0,
                                  ),
                                )),

                            //............................................. end progressive indicator
                          ],
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10.0, bottom: 5.0)),
                    Text(
                      '$slogan',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
                flex: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
