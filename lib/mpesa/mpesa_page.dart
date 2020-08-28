/// Support for doing something awesome.
///
/// More dartdocs go here.
library mpesa;

import 'package:churchapp/mpesa/mpesa.dart';
import 'package:churchapp/mpesa/util/const.dart';
import 'package:churchapp/screens/route_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

export 'mpesa.dart';

// TODO: Export any libraries intended for clients of this package.

class MpesaPage extends StatefulWidget {
  @override
  _MpesaPageState createState() => _MpesaPageState();
}

class _MpesaPageState extends State<MpesaPage> {
  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);

  final Color logoGreen = Color(0xff25bcbb);
  Mpesa  mpesa = Mpesa(
      clientKey: MpesaConst.client_key,
      clientSecret: MpesaConst.client_secret,
      environment: MpesaConst.enviroment,
      initiatorPassword: MpesaConst.int_pass,
      passKey: MpesaConst.pass_key);
  String _number;
  String  _amount;

  // declare Controllers....................
  TextEditingController amount = TextEditingController();

  //declare global keys ........................
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //declare progress dialog
  ProgressDialog pr;

  //validate fields
  bool _validate = false;

//  _MpesaPageState() {
//    mpesa = Mpesa(
//        clientKey: MpesaConst.client_key,
//        clientSecret: MpesaConst.client_secret,
//        environment: MpesaConst.enviroment,
//        initiatorPassword: MpesaConst.int_pass,
//        passKey: MpesaConst.pass_key);
//  }

  void _showSnackBar(String text) {
    _scaffoldKey.currentState.showSnackBar(
      new SnackBar(
        content: Text(
          '$text',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              letterSpacing: 1),
        ),
        backgroundColor: Colors.grey[800],
      ),
    );
  }

  lipaNaMpesa() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String code = "254";
    _number = preferences.getString("mobile");
    int newNumber = int.parse(_number);
    String mobile = code + newNumber.toString();

    final form = _formKey.currentState;
    if (form.validate() && _validate == false) {
      setState(() {
        form.save();
        var  cash=double.parse('$_amount');
        mpesa.lipaNaMpesa(
            phoneNumber: mobile,
            amount: cash,
            businessShortCode: MpesaConst.lipa_mpesa_number,
            callbackUrl: MpesaConst.mpesaCallbackUrl);
      });
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
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
        title: Center(child: Text('Offering')),
        backgroundColor: primaryColor,
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    onSaved: (val) => _amount = val ,
                    controller: amount,
                    style: TextStyle(color: Colors.black26),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        labelText: 'Amount',
                        labelStyle: TextStyle(color: Colors.white),
                        icon: Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                        // prefix: Icon(icon),
                        border: InputBorder.none),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      elevation: 0,
                      height: 40,
                      onPressed: () {
                        setState(
                          () {
                            //validate textFields
                            if (amount.text.isEmpty) {
                              _validate = true;
                              _showSnackBar("Enter amount");
                            } else {
                              if (_formKey.currentState.validate()) {
                                _validate = false;
                                lipaNaMpesa();
                              }
                            }
                          },
                        );
                      },
                      color: logoGreen,
                      child: Text(
                        'Give',
                        style: GoogleFonts.openSans(
                            color: Colors.white, fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
