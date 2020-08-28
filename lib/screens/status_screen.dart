import 'package:churchapp/http/connectivity.dart';
import 'package:churchapp/http/contant/constant.dart';
import 'package:churchapp/screens/route_controller.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';

import 'package:churchapp/models/bookedModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BookingStatus extends StatefulWidget {
  @override
  _BookingStatusState createState() => _BookingStatusState();
}

class _BookingStatusState extends State<BookingStatus> {
  final Color primaryColor = Color(0xff18203d);

  logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      preferences.commit();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RouteController()),
      );
    });
  }

  Future<BookModel> booked;
  bool isConn = true;

  Future<BookModel> getBooked() async {
    //get user id  from pref
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String _userId = preferences.getString("userId");
    // implement getCategories
    // Store all data with Param Name.
    var data = {"user_id": "$_userId"};
    // Starting Web API Call.
    var response = await http.post(Constant.fetchBookUrl, body: data);
    final jsonResponse = jsonDecode(response.body);

    return BookModel.fromJson(jsonResponse);
  }

  checkConn() {
    check().then((internet) {
      if (internet != null && internet) {
        // Internet Present Case
        isConn = true;
      }
      // No-Internet Case
      isConn = false;
    });
  }

  @override
  void initState() {
    super.initState();
    checkConn();
    booked = getBooked();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(8, 1, 1, 1),
          child: Image.asset(
            'assets/images/dcu-logo.png',
            fit: BoxFit.contain,
            height: 25,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () => logOut(),
          ),
        ],
        title: Center(child: Text('Status history')),
        backgroundColor: primaryColor,
      ),
      body: showBooked(),
    );
  }

  Widget showBooked() {
    return FutureBuilder<BookModel>(
      future: booked,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return showMyUI(snapshot.data.booked);
        } else if (snapshot.hasError) {
          return isConn ? Text("${snapshot.error}") : noConnection();
        }
// By default, show a loading spinner.
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget showMyUI(List<Booked> booked) {
    return new ListView.builder(
      itemCount: booked.length,
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: new Container(
            margin: new EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
            child: new Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: InkWell(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Padding(
                          padding: new EdgeInsets.symmetric(vertical: 3.0)),
                      new Text(
                          'Selected Service : ${booked[index].service}'),
                      new Padding(
                          padding: new EdgeInsets.symmetric(vertical: 3.0)),
                      new Text(
                          'No of Seat(s) Reserved : ${booked[index].seatNo}'),
                      new Padding(
                          padding: new EdgeInsets.symmetric(vertical: 3.0)),
                      new Text(
                          'Remaining seats : ${booked[index].availableSeats}'),
                      new Padding(
                          padding: new EdgeInsets.symmetric(vertical: 3.0)),
                      new Text(
                          'Seat(s) Booked :  ${jsonDecode(booked[index].seats)}'),
                      new Padding(
                          padding: new EdgeInsets.symmetric(vertical: 3.0)),
                      new Text('Start : ${booked[index].startHour}'),
                      new Padding(
                          padding: new EdgeInsets.symmetric(vertical: 3.0)),
                      new Text('End: ${booked[index].endHour}'),
                      new Padding(
                          padding: new EdgeInsets.symmetric(vertical: 3.0)),
                      new Text('Date Reserved : ${booked[index].createdAt}'),
                      new Padding(
                          padding: new EdgeInsets.symmetric(vertical: 9.0)),
                      new Text('status : ${booked[index].reservationStatus}'),
                      new Padding(
                          padding: new EdgeInsets.symmetric(vertical: 3.0)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget noConnection() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/wifi.png",
                height: 60,
                width: 60,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "No Internet Connection",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40, left: 40, top: 20),
            child: Container(
              child: Text(
                "You must be connected to the internet to complete this action",
                style: TextStyle(
                    fontSize: 15, color: Color.fromRGBO(220, 220, 220, 1.0)),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ButtonTheme(
            minWidth: 200.0,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: primaryColor)),
              onPressed: () async {
                var connectivityResult =
                    await (Connectivity().checkConnectivity());
                if (connectivityResult == ConnectivityResult.mobile) {
                  setState(() {
                    booked = getBooked();
                    showToast("Refreshing..");
                  });

                  // I am connected to a mobile network.
                } else if (connectivityResult == ConnectivityResult.wifi) {
                  setState(() {
                    booked = getBooked();
                    showToast("Refreshing..");
                  });

                  // I am connected to a wifi network.
                } else if (connectivityResult == ConnectivityResult.none) {
                  // I am connected to a wifi network.
                  showToast("No Connection");
                }
              },
              color: primaryColor,
              textColor: Colors.white,
              child: Text("Try Again".toUpperCase(),
                  style: TextStyle(fontSize: 14)),
            ),
          ),
        ],
      ),
    );
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: '$message',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[800],
        textColor: Colors.white);
  }
}
