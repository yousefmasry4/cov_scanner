import 'dart:async';
import 'package:cov_scanner/utility/Routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cov_scanner/utility/connection.dart';
import 'package:cov_scanner/constants.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool connection_test=false;

  startTime() async {
    await corona_corona.load();
    await IP.get();
    print(IP.ip);
    bool x=await connection_test_fun();
    setState(() {
      connection_test=x;
    });
    var _duration = new Duration(milliseconds: 5000);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    if(connection_test == false){
      print("no connection");
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.no_connection, (Route<dynamic> route) => false);
    }else{
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.home, (Route<dynamic> route) => false);
    }
  }

  @override
  void initState() {
    super.initState();

    startTime();
  }

  final Image _img = new Image.asset(
    'images/logo.gif',
    width: 250,
    height: 250,
  );
  final Image _img_down = new Image.asset(
    'images/s1.gif',
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
              _spacer(150),
              _spacer(20),
              _img,
              _spacer(10),
              Expanded(
                child: SizedBox(),
              ),
              _img_down
            ],
          ),
        ));
  }
}
