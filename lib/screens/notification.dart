import 'dart:async';
import 'package:cov_scanner/utility/Routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cov_scanner/utility/connection.dart';

class NoConnection extends StatefulWidget {
  @override
  _NoConnectionState createState() => _NoConnectionState();
}

class _NoConnectionState extends State<NoConnection> {
  bool connection_test = false;

  startTime() async {
    bool x = await connection_test_fun();
    setState(() {
      connection_test = x;
    });
    var _duration = new Duration(milliseconds: 5000);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    if (connection_test == false) {
      print("no connection");
    } else {
      print("gogogo");
    }
  }

  @override
  void initState() {
    super.initState();

    startTime();
  }

  final Text _intro = new Text(
    "No internet connection",
    style: GoogleFonts.amiko(
      textStyle: TextStyle(
        color: Colors.red,
        fontSize: 40,
        fontWeight: FontWeight.w300,
      ),
    ),
    textAlign: TextAlign.center,
    overflow: TextOverflow.clip,
  );

  // ignore: non_constant_identifier_names
  Widget _spacer(double i) => SizedBox(
        height: i,
      );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _intro,
              _spacer(20),
              IconButton(
                icon: Icon(Icons.refresh),
                tooltip: 'Increase volume by 10',
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.splash, (Route<dynamic> route) => false);
                },
              ),
              Text('try again')
            ],
          ),
        ));
  }
}
