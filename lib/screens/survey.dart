import 'dart:core';
import 'dart:developer';
import 'package:churchapp/http/http_response/http_response.dart';
import 'package:churchapp/models/Response.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';

enum Gender { MALE, FEMALE, OTHER }
enum Age { A, B, C, D, E, F, G, H, I, J }

extension AgeExtension on Age {
  String get age {
    switch (this) {
      case Age.A:
        return '18-24';
      case Age.B:
        return '25-29';
      case Age.C:
        return '30-34';
      case Age.D:
        return '35-39';
      case Age.E:
        return '40-45';
      case Age.F:
        return '46-49';
      case Age.G:
        return '50-55';
      case Age.H:
        return '56-60';
      case Age.I:
        return '61-65';
      case Age.J:
        return 'Above 65';
      default:
        return null;
    }
  }
}

enum Status { none, running, stopped, paused }
enum Education { PHD, DEGREE, DIPLOMA, COLLAGE, KCSE, KCPE, NO_EDUCATION }
enum Online { YES, NO }
enum Employment {
  SELF_EMPLOYED,
  STUDENT,
  UNEMPLOYED,
  EMPLOYED,
  DONT_KNOW,
  REFUSED
}
enum Service { FIRST, SECOND }
enum Yearsdcu {
  LESSMONTH1,
  MONTHS3,
  MONTHS6,
  MONTHS9,
  MONTH12,
  YEARS2,
  YEARS6,
  YEARS10,
  MORETHAN10
}

enum Fellowship {
  WISDOM,
  OVERCOMERS,
  NAZARETH,
  BETHSAIDA,
  GLORY,
  TESTIMONY,
  SHALOM,
  VISION,
  JERUSALEM,
  BETHEL,
  NEEMA,
  BEREA,
  UTUKUFU,
  GENESIS,
  JUDEA,
  AMANI,
  PILLARS,
  EBENEZER,
  SHAMAH,
  KINGDOM,
  IMANI,
  BARAKA,
  DOMINION,
  VINEYARD,
  CHURCH,
  ANYOTHER
}

class SurveyQuiz extends StatefulWidget {
  @override
  _SurveyQuizState createState() => _SurveyQuizState();
}

class _SurveyQuizState extends State<SurveyQuiz> implements HttpCallBack {
  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);

  final Color logoGreen = Color(0xff25bcbb);
  //declare progress dialog
  ProgressDialog pr;
  //validate fields
  bool _validate = false;

  // Declare gender method
  Gender _genderValue;

  //Declare age method
  Age _ageValue;

  //Education method
  Education _educationValue;

  //Online Service methode
  Online _onlineValue;

  //Employment method
  Employment _employmentValue;

  //Service methode
  Service _serviceValue;

  //Years in DCU method
  Yearsdcu _yearsValue;
  // declare Controllers....................
  TextEditingController _mobile = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _location = TextEditingController();
  TextEditingController _belows = TextEditingController();
  TextEditingController _above = TextEditingController();
  TextEditingController _profession = TextEditingController();
  TextEditingController _business = TextEditingController();
  TextEditingController _depServe = TextEditingController();

  //Micro-church method
  Fellowship _fellowshipValue;
  String username;
  String age;
  String gender;
  String EdLevel;
  String location;
  String microChurch;
  String yrsDcu;
  String child_below_13;
  String child_above_13;
  String prefered_service;
  String prof;
  String employment;
  String business;
  String dep_serve;
  String online_service;
  String mobile;

  //declare global keys ........................
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //Declare response
  HttpResponse _response;

  //initialize response
  _SurveyQuizState() {
    _response = new HttpResponse(this);
  }

  //on login button clicked calls this
  void _submit() {
    final form = _formKey.currentState;
    if (form.validate() && _validate == false) {
      setState(
        () {
          form.save();
          _response.doSurvey(
              _username.text,
              age,
              gender,
              EdLevel,
              _location.text,
              microChurch,
              yrsDcu,
              _belows.text,
              _above.text,
              prefered_service,
              prof,
              employment,
              business,
              dep_serve,
              online_service);
        },
      );
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

  @override
  void initState() {
    // implement initState
    super.initState();
    //change status color
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.grey[900]));
  }

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
//      customBody: LinearProgressIndicator(
//        valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
//        backgroundColor: Colors.white,
//      ),
    );

    pr.style(
      message: 'Loading',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
    );
    return Scaffold(
      body: SafeArea(
        key: _scaffoldKey,
        child: Container(
          decoration: new BoxDecoration(
            boxShadow: [
              new BoxShadow(
                  // color: Color(0xffeeeeee),
                  color: Colors.grey[300]),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Container(
                child: ListView(
                  children: <Widget>[
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 10, 5),
                                  child: Text(
                                    "Project_Covid_Study.",
                                    style: GoogleFonts.openSans(
                                        color: Color(0xffbf4503),
                                        fontSize: 28,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              const Divider(
                                color: Colors.grey,
                                height: 20,
                                thickness: 2,
                                indent: 20,
                                endIndent: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 5),
                                child: Text(
                                  "Thank you for participating in this survey that is being conducted by SBO Research Limited on behalf of Deliverance church Utawala. SBO is an independent market research company based in Nairobi. The aim of the survey is to get your opinion on Investment Services.",
                                  style: TextStyle(
                                      color: Color(0xff616161), fontSize: 16.0),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                child: Text(
                                  "We encourage you to provide your honest opinion. The information you provide will remain confidential and the results will be analyzed and reported collectively. As such, no findings will be directly attributed to you as an individual. SBO is bound by the Marketing & Social Research Association (MSRA) Code of Conduct in observing respondent confidentiality.",
                                  style: TextStyle(
                                      color: Color(0xff616161), fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 5),
                                child: Text(
                                  "Please enter your name",
                                  style: TextStyle(
                                      color: Color(0xff616161), fontSize: 16.0),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                child: TextFormField(
                                  onSaved: (val) => username = val,
                                  keyboardType: TextInputType.text,
                                  controller: _username,
                                  decoration: new InputDecoration(
                                    labelText: "Enter Your Name",
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(5.0),
                                      borderSide: new BorderSide(),
                                    ),
                                    //fillColor: Colors.green
                                  ),
                                  validator: (val) {
                                    if (val.length == 0) {
                                      return "Name cannot be empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                  style: new TextStyle(
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 5),
                                child: Text(
                                  "Telephone number",
                                  style: TextStyle(
                                      color: Color(0xff616161), fontSize: 16.0),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                child: TextFormField(
                                  onSaved: (val) => mobile = val,
                                  keyboardType: TextInputType.phone,
                                  controller: _mobile,
                                  decoration: new InputDecoration(
                                    labelText: "+254",
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(5.0),
                                      borderSide: new BorderSide(),
                                    ),
                                    //fillColor: Colors.green
                                  ),
                                  validator: (val) {
                                    if (val.length == 0) {
                                      return "Phone cannot be empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                  style: new TextStyle(
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 5),
                                child: Text(
                                  "AGE",
                                  style: TextStyle(
                                      color: Color(0xff616161), fontSize: 16.0),
                                ),
                              ),
                              RadioListTile(
                                title: const Text('18-24yrs'),
                                value: Age.A,
                                groupValue: _ageValue,
                                onChanged: (Age value) {
                                  setState(() {
                                    _ageValue = value;
                                    Age _age = value;
                                    age = _age.age;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('25-29yrs'),
                                value: Age.B,
                                groupValue: _ageValue,
                                onChanged: (Age value) {
                                  setState(() {
                                    _ageValue = value;
                                    Age _age = value;
                                    age = _age.age;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('30-34yrs'),
                                value: Age.C,
                                groupValue: _ageValue,
                                onChanged: (Age value) {
                                  setState(() {
                                    _ageValue = value;
                                    Age _age = value;
                                    age = _age.age;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('35-39yrs'),
                                value: Age.D,
                                groupValue: _ageValue,
                                onChanged: (Age value) {
                                  setState(() {
                                    _ageValue = value;
                                    Age _age = value;
                                    age = _age.age;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('40-45yrs'),
                                value: Age.E,
                                groupValue: _ageValue,
                                onChanged: (Age value) {
                                  setState(() {
                                    _ageValue = value;
                                    Age _age = value;
                                    age = _age.age;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('46-49yrs'),
                                value: Age.F,
                                groupValue: _ageValue,
                                onChanged: (Age value) {
                                  setState(() {
                                    _ageValue = value;
                                    Age _age = value;
                                    age = _age.age;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('50 -55yrs'),
                                value: Age.G,
                                groupValue: _ageValue,
                                onChanged: (Age value) {
                                  setState(() {
                                    _ageValue = value;
                                    Age _age = value;
                                    age = _age.age;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('56-60yrs'),
                                value: Age.H,
                                groupValue: _ageValue,
                                onChanged: (Age value) {
                                  setState(() {
                                    _ageValue = value;
                                    Age _age = value;
                                    age = _age.age;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('61-65yrs'),
                                value: Age.H,
                                groupValue: _ageValue,
                                onChanged: (Age value) {
                                  setState(() {
                                    _ageValue = value;
                                    Age _age = value;
                                    age = _age.age;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Above 65 yrs'),
                                value: Age.J,
                                groupValue: _ageValue,
                                onChanged: (Age value) {
                                  setState(() {
                                    _ageValue = value;
                                    Age _age = value;
                                    age = _age.age;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 5),
                                child: Text(
                                  "GENDER",
                                  style: TextStyle(
                                      color: Color(0xff616161), fontSize: 16.0),
                                ),
                              ),
                              RadioListTile(
                                title: const Text('Male'),
                                value: Gender.MALE,
                                groupValue: _genderValue,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      _genderValue = value;
                                      String g = value.toString().substring(
                                          value.toString().indexOf('.') + 1);
                                      gender = g;
                                    },
                                  );
                                },
                              ),
                              RadioListTile(
                                title: const Text('Female'),
                                value: Gender.FEMALE,
                                groupValue: _genderValue,
                                onChanged: (Gender value) {
                                  setState(() {
                                    _genderValue = value;
                                    String g = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    gender = g;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Other'),
                                value: Gender.OTHER,
                                groupValue: _genderValue,
                                onChanged: (Gender value) {
                                  setState(() {
                                    _genderValue = value;
                                    String g = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    gender = g;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 5),
                                child: Text(
                                  "HIGHEST LEVEL OF EDUCATION",
                                  style: TextStyle(
                                      color: Color(0xff616161), fontSize: 16.0),
                                ),
                              ),
                              RadioListTile(
                                title: const Text(
                                    'Post graduate degree (Masters/ PHD)'),
                                value: Education.PHD,
                                groupValue: _educationValue,
                                onChanged: (Education value) {
                                  setState(() {
                                    _educationValue = value;
                                    String e = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    EdLevel = e;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Bachelor\'s Degree'),
                                value: Education.DEGREE,
                                groupValue: _educationValue,
                                onChanged: (Education value) {
                                  setState(() {
                                    _educationValue = value;
                                    String e = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    EdLevel = e;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Diploma'),
                                value: Education.DIPLOMA,
                                groupValue: _educationValue,
                                onChanged: (Education value) {
                                  setState(() {
                                    _educationValue = value;
                                    String e = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    EdLevel = e;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('College Certificate'),
                                value: Education.COLLAGE,
                                groupValue: _educationValue,
                                onChanged: (Education value) {
                                  setState(() {
                                    _educationValue = value;
                                    String e = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    EdLevel = e;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('KCSE/ Form 4'),
                                value: Education.KCSE,
                                groupValue: _educationValue,
                                onChanged: (Education value) {
                                  setState(() {
                                    _educationValue = value;
                                    String e = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    EdLevel = e;
                                  });
                                },
                              ),
                              RadioListTile(
                                title:
                                    const Text('Primary school education only'),
                                value: Education.KCPE,
                                groupValue: _educationValue,
                                onChanged: (Education value) {
                                  setState(() {
                                    _educationValue = value;
                                    String e = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    EdLevel = e;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text(
                                    'No education/ did not attend school'),
                                value: Education.NO_EDUCATION,
                                groupValue: _educationValue,
                                onChanged: (Education value) {
                                  setState(() {
                                    _educationValue = value;
                                    String e = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    EdLevel = e;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 5),
                                child: Text(
                                  "Location",
                                  style: TextStyle(
                                      color: Color(0xff616161), fontSize: 16.0),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                child: TextFormField(
                                  onSaved: (val) => location = val,
                                  controller: _location,
                                  decoration: new InputDecoration(
                                    labelText: "location",
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(5.0),
                                      borderSide: new BorderSide(),
                                    ),
                                    //fillColor: Colors.green
                                  ),
                                  validator: (val) {
                                    if (val.length == 0) {
                                      return "Location cannot be empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                  style: new TextStyle(
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 5),
                                child: Text(
                                  "Micro-church name",
                                  style: TextStyle(
                                      color: Color(0xff616161), fontSize: 16.0),
                                ),
                              ),
                              RadioListTile(
                                title: const Text('Wisdom'),
                                value: Fellowship.WISDOM,
                                groupValue: _fellowshipValue,
                                onChanged: (Fellowship value) {
                                  setState(() {
                                    _fellowshipValue = value;
                                    String m = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    microChurch = m;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Overcomers'),
                                value: Fellowship.OVERCOMERS,
                                groupValue: _fellowshipValue,
                                onChanged: (Fellowship value) {
                                  setState(() {
                                    _fellowshipValue = value;
                                    String m = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    microChurch = m;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Nazareth'),
                                value: Fellowship.NAZARETH,
                                groupValue: _fellowshipValue,
                                onChanged: (Fellowship value) {
                                  setState(() {
                                    _fellowshipValue = value;
                                    String m = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    microChurch = m;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Bethsaida'),
                                value: Fellowship.BETHSAIDA,
                                groupValue: _fellowshipValue,
                                onChanged: (Fellowship value) {
                                  setState(() {
                                    _fellowshipValue = value;
                                    String m = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    microChurch = m;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Glory'),
                                value: Fellowship.GLORY,
                                groupValue: _fellowshipValue,
                                onChanged: (Fellowship value) {
                                  setState(() {
                                    _fellowshipValue = value;
                                    String m = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    microChurch = m;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Testimony'),
                                value: Fellowship.TESTIMONY,
                                groupValue: _fellowshipValue,
                                onChanged: (Fellowship value) {
                                  setState(() {
                                    _fellowshipValue = value;
                                    String m = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    microChurch = m;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Shalom'),
                                value: Fellowship.SHALOM,
                                groupValue: _fellowshipValue,
                                onChanged: (Fellowship value) {
                                  setState(() {
                                    _fellowshipValue = value;
                                    String m = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    microChurch = m;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Vision'),
                                value: Fellowship.VISION,
                                groupValue: _fellowshipValue,
                                onChanged: (Fellowship value) {
                                  setState(() {
                                    _fellowshipValue = value;
                                    String m = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    microChurch = m;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Jerusalem'),
                                value: Fellowship.JERUSALEM,
                                groupValue: _fellowshipValue,
                                onChanged: (Fellowship value) {
                                  setState(() {
                                    _fellowshipValue = value;
                                    String m = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    microChurch = m;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Bethel'),
                                value: Fellowship.BETHEL,
                                groupValue: _fellowshipValue,
                                onChanged: (Fellowship value) {
                                  setState(() {
                                    _fellowshipValue = value;
                                    String m = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    microChurch = m;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Neema'),
                                value: Fellowship.NEEMA,
                                groupValue: _fellowshipValue,
                                onChanged: (Fellowship value) {
                                  setState(() {
                                    _fellowshipValue = value;
                                    String m = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    microChurch = m;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Berea'),
                                value: Fellowship.BEREA,
                                groupValue: _fellowshipValue,
                                onChanged: (Fellowship value) {
                                  setState(() {
                                    _fellowshipValue = value;
                                    String m = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    microChurch = m;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Utukufu'),
                                value: Fellowship.UTUKUFU,
                                groupValue: _fellowshipValue,
                                onChanged: (Fellowship value) {
                                  setState(() {
                                    _fellowshipValue = value;
                                    String m = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    microChurch = m;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Genesis'),
                                value: Fellowship.GENESIS,
                                groupValue: _fellowshipValue,
                                onChanged: (Fellowship value) {
                                  setState(() {
                                    _fellowshipValue = value;
                                    String m = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    microChurch = m;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Judea'),
                                value: Fellowship.JUDEA,
                                groupValue: _fellowshipValue,
                                onChanged: (Fellowship value) {
                                  setState(() {
                                    _fellowshipValue = value;
                                    String m = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    microChurch = m;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Amani'),
                                value: Fellowship.AMANI,
                                groupValue: _fellowshipValue,
                                onChanged: (Fellowship value) {
                                  setState(() {
                                    _fellowshipValue = value;
                                    String m = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    microChurch = m;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Pillars'),
                                value: Fellowship.PILLARS,
                                groupValue: _fellowshipValue,
                                onChanged: (Fellowship value) {
                                  setState(() {
                                    _fellowshipValue = value;
                                    String m = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    microChurch = m;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Ebenezer'),
                                value: Fellowship.EBENEZER,
                                groupValue: _fellowshipValue,
                                onChanged: (Fellowship value) {
                                  setState(() {
                                    _fellowshipValue = value;
                                    String m = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    microChurch = m;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Shamah'),
                                value: Fellowship.SHAMAH,
                                groupValue: _fellowshipValue,
                                onChanged: (Fellowship value) {
                                  setState(() {
                                    _fellowshipValue = value;
                                    String m = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    microChurch = m;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Kingdom'),
                                value: Fellowship.KINGDOM,
                                groupValue: _fellowshipValue,
                                onChanged: (Fellowship value) {
                                  setState(() {
                                    _fellowshipValue = value;
                                    String m = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    microChurch = m;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Imani'),
                                value: Fellowship.IMANI,
                                groupValue: _fellowshipValue,
                                onChanged: (Fellowship value) {
                                  setState(() {
                                    _fellowshipValue = value;
                                    String m = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    microChurch = m;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Baraka'),
                                value: Fellowship.BARAKA,
                                groupValue: _fellowshipValue,
                                onChanged: (Fellowship value) {
                                  setState(() {
                                    _fellowshipValue = value;
                                    String m = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    microChurch = m;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Dominion'),
                                value: Fellowship.DOMINION,
                                groupValue: _fellowshipValue,
                                onChanged: (Fellowship value) {
                                  setState(() {
                                    _fellowshipValue = value;
                                    String m = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    microChurch = m;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Vineyard'),
                                value: Fellowship.VINEYARD,
                                groupValue: _fellowshipValue,
                                onChanged: (Fellowship value) {
                                  setState(() {
                                    _fellowshipValue = value;
                                    String m = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    microChurch = m;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Church'),
                                value: Fellowship.CHURCH,
                                groupValue: _fellowshipValue,
                                onChanged: (Fellowship value) {
                                  setState(() {
                                    _fellowshipValue = value;
                                    String m = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    microChurch = m;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Any Other'),
                                value: Fellowship.ANYOTHER,
                                groupValue: _fellowshipValue,
                                onChanged: (Fellowship value) {
                                  setState(() {
                                    _fellowshipValue = value;
                                    String m = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    microChurch = m;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 5),
                                child: Text(
                                  "Years with DCU",
                                  style: TextStyle(
                                      color: Color(0xff616161), fontSize: 16.0),
                                ),
                              ),
                              RadioListTile(
                                title: const Text('Less than 1 month'),
                                value: Yearsdcu.LESSMONTH1,
                                groupValue: _yearsValue,
                                onChanged: (Yearsdcu value) {
                                  setState(() {
                                    _yearsValue = value;
                                    String dcu = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    yrsDcu = dcu;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('1-3 months'),
                                value: Yearsdcu.MONTHS3,
                                groupValue: _yearsValue,
                                onChanged: (Yearsdcu value) {
                                  setState(() {
                                    _yearsValue = value;
                                    String dcu = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    yrsDcu = dcu;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('3-6 months'),
                                value: Yearsdcu.MONTHS6,
                                groupValue: _yearsValue,
                                onChanged: (Yearsdcu value) {
                                  setState(() {
                                    _yearsValue = value;
                                    String dcu = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    yrsDcu = dcu;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('6-9 months'),
                                value: Yearsdcu.MONTHS9,
                                groupValue: _yearsValue,
                                onChanged: (Yearsdcu value) {
                                  setState(() {
                                    _yearsValue = value;
                                    String dcu = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    yrsDcu = dcu;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('9-12 months'),
                                value: Yearsdcu.MONTH12,
                                groupValue: _yearsValue,
                                onChanged: (Yearsdcu value) {
                                  setState(() {
                                    _yearsValue = value;
                                    String dcu = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    yrsDcu = dcu;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('1-2 years'),
                                value: Yearsdcu.YEARS2,
                                groupValue: _yearsValue,
                                onChanged: (Yearsdcu value) {
                                  setState(() {
                                    _yearsValue = value;
                                    String dcu = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    yrsDcu = dcu;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('2-6 years'),
                                value: Yearsdcu.YEARS6,
                                groupValue: _yearsValue,
                                onChanged: (Yearsdcu value) {
                                  setState(() {
                                    _yearsValue = value;
                                    String dcu = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    yrsDcu = dcu;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('6-10 years'),
                                value: Yearsdcu.YEARS10,
                                groupValue: _yearsValue,
                                onChanged: (Yearsdcu value) {
                                  setState(() {
                                    _yearsValue = value;
                                    String dcu = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    yrsDcu = dcu;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('More than 10 years'),
                                value: Yearsdcu.MORETHAN10,
                                groupValue: _yearsValue,
                                onChanged: (Yearsdcu value) {
                                  setState(() {
                                    _yearsValue = value;
                                    String dcu = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    yrsDcu = dcu;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 5),
                                child: Text(
                                  "Children Below 13 years",
                                  style: TextStyle(
                                      color: Color(0xff616161), fontSize: 16.0),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                child: TextFormField(
                                  onSaved: (val) => child_above_13 = val,
                                  keyboardType: TextInputType.number,
                                  controller: _above,
                                  decoration: new InputDecoration(
                                    labelText: "<13 years",
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(5.0),
                                      borderSide: new BorderSide(),
                                    ),
                                    //fillColor: Colors.green
                                  ),
                                  validator: (val) {
                                    if (val.length == 0) {
                                      return "Type zero is you have none";
                                    } else {
                                      return null;
                                    }
                                  },
                                  style: new TextStyle(
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 5),
                                child: Text(
                                  "Children Above 13 years",
                                  style: TextStyle(
                                      color: Color(0xff616161), fontSize: 16.0),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                child: TextFormField(
                                  onSaved: (val) => child_below_13 = val,
                                  keyboardType: TextInputType.number,
                                  controller: _belows,
                                  decoration: new InputDecoration(
                                    labelText: ">13 years",
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(5.0),
                                      borderSide: new BorderSide(),
                                    ),
                                    //fillColor: Colors.green
                                  ),
                                  validator: (val) {
                                    if (val.length == 0) {
                                      return "Type zero is you have none";
                                    } else {
                                      return null;
                                    }
                                  },
                                  style: new TextStyle(
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 5),
                                child: Text(
                                  "Preferred service",
                                  style: TextStyle(
                                      color: Color(0xff616161), fontSize: 16.0),
                                ),
                              ),
                              RadioListTile(
                                title: const Text('1st service'),
                                value: Service.FIRST,
                                groupValue: _serviceValue,
                                onChanged: (Service value) {
                                  setState(() {
                                    _serviceValue = value;
                                    String service = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    prefered_service = service;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('2nd service'),
                                value: Service.SECOND,
                                groupValue: _serviceValue,
                                onChanged: (Service value) {
                                  setState(() {
                                    _serviceValue = value;
                                    String service = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    prefered_service = service;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 5),
                                child: Text(
                                  "What's your profession",
                                  style: TextStyle(
                                      color: Color(0xff616161), fontSize: 16.0),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                child: TextFormField(
                                  onSaved: (val) => prof = val,
                                  keyboardType: TextInputType.text,
                                  controller: _profession,
                                  decoration: new InputDecoration(
                                    labelText: "profession",
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(5.0),
                                      borderSide: new BorderSide(),
                                    ),
                                    //fillColor: Colors.green
                                  ),
                                  validator: (val) {
                                    if (val.length == 0) {
                                      return "profession can't be empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                  style: new TextStyle(
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 5),
                                child: Text(
                                  "Employment",
                                  style: TextStyle(
                                      color: Color(0xff616161), fontSize: 16.0),
                                ),
                              ),
                              RadioListTile(
                                title: const Text('Self-employed'),
                                value: Employment.SELF_EMPLOYED,
                                groupValue: _employmentValue,
                                onChanged: (Employment value) {
                                  setState(() {
                                    _employmentValue = value;
                                    String emp = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    employment = emp;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Student'),
                                value: Employment.STUDENT,
                                groupValue: _employmentValue,
                                onChanged: (Employment value) {
                                  setState(() {
                                    _employmentValue = value;
                                    String emp = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    employment = emp;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Unemployed'),
                                value: Employment.UNEMPLOYED,
                                groupValue: _employmentValue,
                                onChanged: (Employment value) {
                                  setState(() {
                                    _employmentValue = value;
                                    String emp = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    employment = emp;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Employed'),
                                value: Employment.EMPLOYED,
                                groupValue: _employmentValue,
                                onChanged: (Employment value) {
                                  setState(() {
                                    _employmentValue = value;
                                    String emp = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    employment = emp;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Don\'t know'),
                                value: Employment.DONT_KNOW,
                                groupValue: _employmentValue,
                                onChanged: (Employment value) {
                                  setState(() {
                                    _employmentValue = value;
                                    String emp = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    employment = emp;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('Refused'),
                                value: Employment.REFUSED,
                                groupValue: _employmentValue,
                                onChanged: (Employment value) {
                                  setState(() {
                                    _employmentValue = value;
                                    String emp = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    employment = emp;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 5),
                                child: Text(
                                  "Business",
                                  style: TextStyle(
                                      color: Color(0xff616161), fontSize: 16.0),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                child: TextFormField(
                                  onSaved: (val) => business = val,
                                  keyboardType: TextInputType.text,
                                  controller: _business,
                                  decoration: new InputDecoration(
                                    labelText: "business",
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(5.0),
                                      borderSide: new BorderSide(),
                                    ),
                                    //fillColor: Colors.green
                                  ),
                                  validator: (val) {
                                    if (val.length == 0) {
                                      return "Type N/A if you are not in business";
                                    } else {
                                      return null;
                                    }
                                  },
                                  style: new TextStyle(
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 5),
                                child: Text(
                                  "Preferred department to serve",
                                  style: TextStyle(
                                      color: Color(0xff616161), fontSize: 16.0),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                child: TextFormField(
                                  onSaved: (val) => dep_serve = val,
                                  keyboardType: TextInputType.text,
                                  controller: _depServe,
                                  decoration: new InputDecoration(
                                    labelText: "department",
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(5.0),
                                      borderSide: new BorderSide(),
                                    ),
                                    //fillColor: Colors.green
                                  ),
                                  validator: (val) {
                                    if (val.length == 0) {
                                      return "Type N/A if not interested";
                                    } else {
                                      return null;
                                    }
                                  },
                                  style: new TextStyle(
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 5),
                                child: Text(
                                  "Do you receive our online service",
                                  style: TextStyle(
                                      color: Color(0xff616161), fontSize: 16.0),
                                ),
                              ),
                              RadioListTile(
                                title: const Text('YES'),
                                value: Online.YES,
                                groupValue: _onlineValue,
                                onChanged: (Online value) {
                                  setState(() {
                                    _onlineValue = value;
                                    String yn = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    online_service = yn;
                                  });
                                },
                              ),
                              RadioListTile(
                                title: const Text('NO'),
                                value: Online.NO,
                                groupValue: _onlineValue,
                                onChanged: (Online value) {
                                  setState(() {
                                    _onlineValue = value;
                                    String yn = value.toString().substring(
                                        value.toString().indexOf('.') + 1);
                                    online_service = yn;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: MaterialButton(
                        color: Colors.deepPurple[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: logoGreen),
                        ),
                        onPressed: () async {
                          if (_username.text.isEmpty &&
                              _mobile.text.isEmpty &&
                              _business.text.isEmpty) {
                            showToast("Fields required");
                            _validate = true;
                          } else if (_mobile.text.isEmpty &&
                              _username.text.isNotEmpty) {
                            showToast("Mobile required");
                            _validate = true;
                          } else if (_mobile.text.isNotEmpty &&
                              _username.text.isEmpty) {
                            showToast("Name required");
                            _validate = true;
                          } else {
                            if (_formKey.currentState.validate()) {
                              pr.show();
                              _validate = false;
                              _submit();
                            }
                          }
                        },
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ),
                  ],
                ),
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
    log('Survey error: $error');
  }

  @override
  void onSuccess(Response response) {
    // implement onSuccess
    if (response != null) {
      if (response.error == false) {
        pr.hide();
        String message = response.message;
        showToast("$message");
        Navigator.pushNamed(context, 'MyNavBar');
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
}

class Submit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(),
      ),
    );
  }
}
