import 'dart:developer';
import 'package:churchapp/http/http_response/http_response.dart';
import 'package:churchapp/models/Response.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_screen.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

enum LoginStatus { notSignIn, signIn }

class _ResetPasswordState extends State<ResetPassword> implements HttpCallBack {
  //default settings
  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);

  final Color logoGreen = Color(0xff25bcbb);

//declare variables ........................
  String mobile;
  String password;
  String rePassword;

  //declare progress dialog
  ProgressDialog pr;

  //validate fields
  bool _validate = false;

  // declare Controllers....................
  TextEditingController _mobile = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _repassword = TextEditingController();

  //declare global keys ........................
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //Declare response
  HttpResponse _response;

  //initialize response
  _ResetPasswordState() {
    _response = new HttpResponse(this);
  }

  //on login button clicked calls this
  void _submit() {
    final form = _formKey.currentState;
    if (form.validate() && _validate == false) {
      setState(() {
        form.save();
        _response.doReset(mobile, password);
      });
    }
  }

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

  //show toast message
  void showToast(String message) {
    Fluttertoast.showToast(
        msg: '$message',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[800],
        textColor: Colors.white);
  }

  @override
  void initState() {
    // implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
    );

    pr.style(
      message: 'Loading',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: primaryColor,
      body: Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/dcu-logo.png',
                    height: 100,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //Texts and Styling of them
                  Text(
                    'Deliverance Church Int\'l Utawala ',
                    textAlign: TextAlign.center,
                    style:
                        GoogleFonts.openSans(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Let\'s reset your password',
                    textAlign: TextAlign.center,
                    style:
                        GoogleFonts.openSans(color: Colors.white, fontSize: 14),
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      obscureText: false,
                      keyboardType: TextInputType.phone,
                      onSaved: (val) => mobile = val,
                      controller: _mobile,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelText: 'Phone',
                          labelStyle: TextStyle(color: Colors.white),
                          icon: Icon(
                            Icons.phone,
                            color: Colors.white,
                          ),
                          // prefix: Icon(icon),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      onSaved: (val) => password = val,
                      controller: _password,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelText: 'New password',
                          labelStyle: TextStyle(color: Colors.white),
                          icon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          // prefix: Icon(icon),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      onSaved: (val) => rePassword = val,
                      controller: _repassword,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelText: 'Confirm password',
                          labelStyle: TextStyle(color: Colors.white),
                          icon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          // prefix: Icon(icon),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 20,
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

                              if (_mobile.text.isEmpty &&
                                  _password.text.isEmpty) {
                                _validate = true;
                                _showSnackBar("Fields required");
                              } else if (_mobile.text.isNotEmpty &&
                                  _password.text.isEmpty) {
                                _validate = true;
                                _showSnackBar("Password required");
                              } else if (_mobile.text.isEmpty &&
                                  _password.text.isNotEmpty) {
                                _validate = true;
                                _showSnackBar("Mobile required");
                              } else {
                                if (_password.text != _repassword.text) {
                                  _validate = true;
                                  _showSnackBar("Passwords not matching");
                                } else {
                                  if (_formKey.currentState.validate()) {
                                    pr.show();
                                    _validate = false;
                                    _submit();
                                  }
                                }
                              }
                            },
                          );
                        },
                        color: logoGreen,
                        child: Text(
                          'Reset',
                          style: GoogleFonts.openSans(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                    ],
                  ),

                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Remembered Password? ',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                            color: Colors.white, fontSize: 14),
                      ),
                      SizedBox(width: 5),
                      GestureDetector(
                        child: Text(
                          'Login',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(
                              color: logoGreen,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onError(String error) {
    // implement onError
    pr.hide();
    log('Login error: $error');
  }

  @override
  void onSuccess(Response response) {
    // implement onSuccess

    if (response != null) {
      if (response.error == false) {
        pr.hide();
        String message = response.message;
        showToast("$message");
        setState(() {});
        Navigator.pushNamed(context, 'LogIn');
      } else if (response.error == true) {
        pr.hide();
        String message = response.message;
        showToast("$message");
      }
    } else {
      pr.hide();
      showToast("failed");
    }
  }

  savePref(int value, String userId, String email, String mobile) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(
      () {
        preferences.setInt("value", value);
        preferences.setString("userId", userId);
        preferences.setString("email", email);
        preferences.setString("mobile", mobile);
        preferences.commit();
      },
    );
  }
}
