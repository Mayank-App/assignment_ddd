import 'dart:async';

import 'package:assignment_ddd/utils/routes/routes_imports.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


@AutoRouter()
class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Timer(const Duration(seconds: 2),
              () {
         AutoRouter.of(context).push( const HomeScreenRoute());
              });
    } else
    {
      Timer(const Duration(seconds: 2), () {
        AutoRouter.of(context).push( const SignInScreenRoute());
      });
    }
  }
}
