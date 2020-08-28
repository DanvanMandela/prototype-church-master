import 'package:churchapp/screens/route_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
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
        title: Center(
          child: Text('Welcome'),
        ),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Our Strategic statements",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                            color: Colors.black87,
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Vision :",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.openSans(
                              color: Colors.deepPurple,
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          '''The church of choice transforming and empowering mankind in Africa and beyond.''',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(
                              color: Colors.black87,
                              fontWeight: FontWeight.w400)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Mission :",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(
                              color: Colors.deepPurple,
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          '''To equip mankind for the mission of God.''',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(
                              color: Colors.black87,
                              fontWeight: FontWeight.w400)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Core Values :",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(
                              color: Colors.deepPurple,
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '''1. Wisdom\n\n2. Holiness\n\n3. Excellence\n\n4. Love\n\n5. Fellowship''',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.openSans(
                            color: Colors.black87, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 3,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text("ODER OF SERVICE",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            fontSize: 18)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                        '''1st Service   [7:30am - 9:30am]\n\nSunday school   [9:30am - 10:15am]\n\n2nd Service   [10:15am - 12:15pm]\n\nTeen's service   [2:00pm - 3:00pm]\n\n\n\nTuesday Micro-church   [7:30pm - 8:30pm]\n\nFriday ignite service   [7:00pm - 8:30pm]''',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.openSans(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500)),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
