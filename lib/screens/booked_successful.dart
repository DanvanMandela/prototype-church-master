import 'package:churchapp/screens/route_controller.dart';
import 'package:churchapp/screens/seats/successful_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'booking_screen.dart';

class BookedSuccess extends StatefulWidget {
  @override
  _BookedSuccessState createState() => _BookedSuccessState();
}

class _BookedSuccessState extends State<BookedSuccess> {
  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);

  final Color logoGreen = Color(0xff25bcbb);
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/dcu-logo.png',
              fit: BoxFit.contain,
              height: 100,
            ),
            Center(
              child: Text(
                  "Deliverance Church Int'l Utawala\n-The Church of Choice-",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w500,
                      fontSize: 18)),
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text("RESERVATION SUCCESSFUL!",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                                fontSize: 18)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              'Thank you for choosing :',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'DELIVERANCE CHURCH INT\'l UTAWALA',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.w800),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Kindly keep time.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: logoGreen),
                              ),
                              elevation: 5,
                              height: 40,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BookASeat()),
                                );
                              },
                              color: logoGreen,
                              child: Text(
                                'Add Seats',
                                style: GoogleFonts.openSans(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: logoGreen),
                              ),
                              elevation: 5,
                              height: 40,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SuccessfulNavBar()),
                                );
                              },
                              color: logoGreen,
                              child: Text(
                                'Go To Status',
                                style: GoogleFonts.openSans(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
