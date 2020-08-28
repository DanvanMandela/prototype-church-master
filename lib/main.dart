import 'package:churchapp/screens/booked_successful.dart';
import 'package:churchapp/screens/navigation_bar.dart';
import 'registration/login_screen.dart';
import 'registration/signup_screen.dart';
import 'package:churchapp/screens/survey.dart';
import 'package:flutter/material.dart';
import 'screens/loading_screen.dart';
import 'screens/route_controller.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up Screen ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: 'LoadingScreen',
      routes: {
        'SurveyQuiz': (context) => SurveyQuiz(),
        'LoadingScreen': (context) => LoadingScreen(),
        'RouteController': (context) => RouteController(),
        'LogIn': (context) => LoginScreen(),
        'SignUp': (context) => SignUpScreen(),
        'Home': (context) => SurveyQuiz(),
        'Survey': (context) => SurveyQuiz(),
        'MyNavBar': (context) => MyNavBar(),
        'BookedSuccess': (context) => BookedSuccess(), //add this to routes
      },
    );
  }
  //f
}
