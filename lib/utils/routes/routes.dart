import 'package:assignment_ddd/presentation/view/home_screen.dart';
import 'package:assignment_ddd/presentation/view/login_screeen.dart';
import 'package:assignment_ddd/presentation/view/signup_screen.dart';
import 'package:assignment_ddd/utils/routes/routes_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../presentation/view/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => SplashScreen());
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) =>SignInScreen() );
      case RoutesName.singup:
        return MaterialPageRoute(
            builder: (BuildContext context) =>SignUpScreen());
      case RoutesName.homeScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text("No routes are there"),
            ),
          );
        });
    }
  }
}
