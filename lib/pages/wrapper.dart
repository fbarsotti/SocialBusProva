import 'package:flutter/material.dart';
import 'login_register.dart';

class Wrapper extends StatelessWidget {
  static const String id = "HOMESCREEN";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    // Stroked text as border.
 /*                   Text(
                      'SocialBus',
                      style: TextStyle(
                      
                        letterSpacing: 5,
                        fontSize: 40,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 7
                          ..color = Colors.black,
                      ),
                    ),*/
                    // Solid text as fill.
                    Text(
                      'SocialBus',
                      style: TextStyle(
                        //fontWeight: FontWeight.bold,
                        letterSpacing: 5,
                        fontSize: 40,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                )
              ],
            ),
                 SizedBox(
              height: MediaQuery.of(context).size.width*0.10,
            ),
            Center(
              child: Hero(
                tag: 'logo',
                child: Container(
                  width: MediaQuery.of(context).size.width*0.50,
                  child: Image.asset("assets/image/logo.jpeg"),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width*0.25,
            ),
            CustomButton(
              text: "Log In",
              callback: () {
                Navigator.of(context).pushNamed('/login');
              },
            ),
            CustomButton(
              text: "Register",
              callback: () {
                Navigator.of(context).pushNamed('/registration');
              },
            )
          ],
        ),
      ),
    );
  }
}
