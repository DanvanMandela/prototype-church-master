import 'dart:developer';
import 'package:churchapp/http/http_response/http_response.dart';
import 'package:churchapp/models/Response.dart';
import 'package:churchapp/registration/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

enum LoginStatus { notSignIn, signIn }

class _SignUpScreenState extends State<SignUpScreen> implements HttpCallBack {
  //declare colors...............
  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);

  final Color logoGreen = Color(0xff25bcbb);

  //declare variables ........................
  String mobile;
  String email;
  String password;

  //declare progress dialog
  ProgressDialog pr;

  //validate fields
  bool _validate = false;

  //login status declaration
  LoginStatus _loginStatus = LoginStatus.notSignIn;

  // declare Controllers....................
  TextEditingController _mobile = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _conPassword = TextEditingController();

  //declare global keys ........................
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //
  String emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  String mobilePattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';

  //Declare response
  HttpResponse _response;

  //initialize response
  _SignUpScreenState() {
    _response = new HttpResponse(this);
  }

  //on login button clicked calls this
  void _submit() {
    final form = _formKey.currentState;
    if (form.validate() && _validate == false) {
      setState(() {
        form.save();
        _response.doSign(email, mobile, password);
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      key: _scaffoldKey, //Scaffold key/............
      backgroundColor: primaryColor,

      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sign in to DCU and continue',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 25),
                ),
                SizedBox(height: 10),
                Text(
                  'Enter your Phone number, Email address and password below to continue to the Deliverance Church Int\'l Utawala!',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 14),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      // color: secondaryColor,
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    obscureText: false,
                    keyboardType: TextInputType.phone,
                    onSaved: (val) => mobile = val,
                    controller: _mobile,
                    style:
                        GoogleFonts.openSans(color: Colors.white, fontSize: 14),
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
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      // color: secondaryColor,
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    onSaved: (val) => email = val,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    controller: _email,
                    style:
                        GoogleFonts.openSans(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white),
                        icon: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        // prefix: Icon(icon),
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      // color: secondaryColor,
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    onSaved: (val) => password = val,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    controller: _password,
                    style:
                        GoogleFonts.openSans(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        labelText: 'Password',
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
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      // color: secondaryColor,
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    controller: _conPassword,
                    style:
                        GoogleFonts.openSans(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        labelText: 'Cofirm Password',
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
                  height: 25,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    child: RaisedButton(
                      elevation: 0,
                      // height: 40,
                      onPressed: () {
                        setState(
                          () {
                            if (_mobile.text.isEmpty &&
                                _email.text.isEmpty &&
                                _password.text.isEmpty) {
                              _validate = true;
                              _showSnackBar("Fields required");
                            } else if (_mobile.text.isNotEmpty &&
                                _email.text.isEmpty &&
                                _password.text.isEmpty) {
                              _validate = true;
                              _showSnackBar("Fields required");
                            }
                            if (_mobile.text.isEmpty &&
                                _email.text.isEmpty &&
                                _password.text.isNotEmpty) {
                              _validate = true;
                              _showSnackBar("Fields required");
                            }
                            if (_mobile.text.isEmpty &&
                                _email.text.isNotEmpty &&
                                _password.text.isEmpty) {
                              _validate = true;
                              _showSnackBar("Fields required");
                            } else if (_mobile.text.isEmpty &&
                                _email.text.isNotEmpty &&
                                _password.text.isNotEmpty) {
                              _validate = true;
                              _showSnackBar("Mobile  required");
                            } else if (_mobile.text.isNotEmpty &&
                                _email.text.isEmpty &&
                                _password.text.isNotEmpty) {
                              _validate = true;
                              _showSnackBar("Email  required");
                            } else if (_mobile.text.isNotEmpty &&
                                _email.text.isNotEmpty &&
                                _password.text.isEmpty) {
                              _validate = true;
                              _showSnackBar("Email  required");
                            } else if (_mobile.text.isNotEmpty &&
                                _email.text.isNotEmpty &&
                                _password.text.isNotEmpty) {
                              RegExp regexEmail = RegExp(emailPattern);
                              if (!regexEmail.hasMatch(_email.text)) {
                                _showSnackBar("Enter valid email address");
                              } else {
                                if (_conPassword.text != _password.text) {
                                  _showSnackBar("password not matching");
                                } else {
                                  if (_formKey.currentState.validate()) {
                                    pr.show();
                                    _validate = false;
                                    _submit();
                                  }
                                }
                              }
                            }
                          },
                        );
                      },

                      color: logoGreen,
                      child: Text(
                        'Register',
                        style: GoogleFonts.openSans(
                            color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _buildFooterLogo(),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Already have an Account?',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                            color: Colors.white, fontSize: 14),
                      ),
                      SizedBox(width: 5),
                      GestureDetector(
                        child: Text(
                          'SignIn',
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
                ),
              ],
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
    log('Sign error: $error');
  }

  @override
  void onSuccess(Response response) {
    // implement onSuccess
    if (response != null) {
      if (response.error == false) {
        pr.hide();
        String message = response.user['message'];
        String userId = response.user['user_id'];
        String mobile = response.user['mobile'];
        String email = response.user['email'];
        showToast("Welcome back $email");
        savePref(1, userId, email, mobile);
        setState(() {});
        _loginStatus = LoginStatus.signIn;
        Navigator.pushNamed(context, 'Survey');
      } else if (response.error == true) {
        pr.hide();
        String message = response.message;
        showToast("$message");
      }
    } else {
      pr.hide();
      showToast("failed try later");
    }
  }

  savePref(int value, String userId, String email, String mobile) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("userId", userId);
      preferences.setString("email", email);
      preferences.setString("mobile", mobile);
      preferences.commit();
    });
  }
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

_buildFooterLogo() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Image.asset(
        'assets/images/dcu-logo.png',
        height: 40,
      ),
      SizedBox(
        height: 10,
      ),
      Text('Deliverance Church Utawala',
          textAlign: TextAlign.center,
          style: GoogleFonts.openSans(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300)),
    ],
  );
}
