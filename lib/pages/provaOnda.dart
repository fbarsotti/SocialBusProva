import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prova/widget/app_drawer.dart';

class ProvaOnda extends StatefulWidget {
  final AuthResult user;
  ProvaOnda({Key key, this.user}) : super(key: key);

  @override
  ProvaOndaState createState() => ProvaOndaState();
}

/// Construct a color from a hex code string, of the format #RRGGBB.
Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

class ProvaOndaState extends State<ProvaOnda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: hexToColor("#0058A5"),
        title: Row(
          children: <Widget>[
            Text(
              'Onda grafica',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Comfortaa',
              ),
            ),
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          // Box decoration takes a gradient
          color: Colors.grey[200],
        ),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.90,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                0,
                25,
                0,
                0,
              ),
              //builder di "container_bus da flie json"
            ),
          ),
        ),
      ),
    );
  }
}
