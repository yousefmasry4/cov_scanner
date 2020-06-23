import 'package:cov_scanner/screens/notification.dart';
import 'package:cov_scanner/screens/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:cov_scanner/screens/home_screen.dart';
import 'package:cov_scanner/screens/info.dart';

class Routes {
  static String m1="";
  static String m2="";
  // Route name constants
  static const String splash = '/splash';
  static const String no_connection = '/no_connection';
  static const String info = '/info';

  static String home="/home";

  /// The map used to define our routes, needs to be supplied to [MaterialApp]
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      Routes.splash: (context) => SplashScreen(),
      Routes.no_connection: (context) => NoConnection(),
      Routes.home: (context) => HomeScreen(),
      Routes.info: (context) => InfoScreen(m1,m2)

    };
  }
}