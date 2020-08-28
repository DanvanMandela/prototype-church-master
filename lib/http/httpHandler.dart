import 'dart:convert';
import 'package:churchapp/http/contant/constant.dart';
import 'package:churchapp/models/Response.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HttpHandler {
  //login
  Future<Response> Login(String mobile, String password) async {
    // Getting value from Controller
    String _mobile = mobile;
    String _password = password;

    // Store all data with Param Name.
    var data = {
      "mobile": "$_mobile",
      "password": "$_password",
    };

    // Starting Web API Call.
    var response = await http.post(Constant.loginUrl, body: data);
    // Getting Server response into variable.
    final rData = jsonDecode(response.body);
    print('Login Response: ${response.body}.');
    return Response.fromLoginResponse(rData);
  }

  //sign
  Future<Response> sign(String email, String mobile, String password) async {
    // Getting value from Controller
    String _mobile = mobile;
    String _password = password;
    String _email = email;

    //Store all data with param name.
    var data = {
      "mobile": "$_mobile",
      "password": "$_password",
      "email": "$_email"
    };

    // Starting Web API Call.
    var response = await http.post(Constant.signUrl, body: data);
    // Getting Server response into variable.
    final rData = jsonDecode(response.body);
    print('Sign Response: ${response.body}.');
    return Response.fromLoginResponse(rData);
  }

  //add survey
  Future<Response> survey(
      String username,
      String age,
      String gender,
      String EdLevel,
      String location,
      String microChurch,
      String yrsDcu,
      String child_below_13,
      String child_above_13,
      String prefered_service,
      String prof,
      String employment,
      String business,
      String dep_serve,
      String online_service) async {
    //get user id  from pref
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String _userId = preferences.getString("userId");

    // Getting value from Controller
    String _username = username;
    String _age = age;
    String _gender = gender;
    String _edLevel = EdLevel;
    String _location = location;
    String _microChurch = microChurch;
    String _yrsDcu = yrsDcu;
    String _childBelow = child_below_13;
    String _childAbove = child_above_13;
    String _prefService = prefered_service;
    String _prof = prof;
    String _employment = employment;
    String _business = business;
    String _depServe = dep_serve;
    String _onlineService = online_service;

    //Store all data with param name.
    var data = {
      "user_id": "$_userId",
      "full_name": "$_username",
      "age": "$_age",
      "gender": "$_gender",
      "education_level": "$_edLevel",
      "address": "$_location",
      "micro_church_name": "$_microChurch",
      "years_with_dcu": "$_yrsDcu",
      "children_below_13": "$_childBelow",
      "children_above_13": "$_childAbove",
      "prefred_service": "$_prefService",
      "profession": "$_prof",
      "employment": "$_employment",
      "business": "$_business",
      "pref_dep_serve": "$_depServe",
      "online_service": "$_onlineService"
    };

    // Starting Web API Call.
    var response = await http.post(Constant.surveyUrl, body: data);
    // Getting Server response into variable.
    final rData = jsonDecode(response.body);
    print('Survey Response: ${response.body}.');
    return Response.fromResponse(rData);
  }

  //book seat
  Future<Response> bookSeat(
      String service, int seats, int church, String seat) async {
    //get user id  from pref
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String _userId = preferences.getString("userId");

    // Getting value from Controller
    String _service = service;
    int _seat = seats;
    int _church = church;

    String json = seat;

    //Store all data with param name.
    var data = {
      "user_id": "$_userId",
      "service_name": "$_service",
      "seatNo": "$_seat",
      "church_id": "$_church",
      "seats": "$json",
    };

    // Starting Web API Call.
    var response = await http.post(Constant.bookUrl, body: data);
    // Getting Server response into variable.
    final rData = jsonDecode(response.body);
    print('Survey Response: ${response.body}.');
    return Response.fromResponse(rData);
  }

  //sign
  Future<Response> restPassword(String mobile, String password) async {
    // Getting value from Controller
    String _mobile = mobile;
    String _password = password;

    //Store all data with param name.
    var data = {
      "mobile": "$_mobile",
      "password": "$_password",
    };

    // Starting Web API Call.
    var response = await http.post(Constant.resetPassword, body: data);
    // Getting Server response into variable.
    final rData = jsonDecode(response.body);
    print('Reset Password Response: ${response.body}.');
    return Response.fromResponse(rData);
  }
}
