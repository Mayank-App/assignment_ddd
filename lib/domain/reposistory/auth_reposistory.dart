import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthReposistory {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<bool?> registerUserWithEmailPassword(String email, String password) async{
    bool? res;
    await auth.createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      res = true;
      debugPrint("Success SignUp");
    }).onError((error, stackTrace) {
      debugPrint("Error While SignUp $error");
      res = false;

    });
    return res;
  }
//Methos to login using email password
  Future<bool?> loginUsingEmailAndPassword(String email, String password) async {
    bool? res;
    debugPrint("Email :$email \n Password: $password");
    await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      debugPrint("SignIn Sucess");
      res = true;
    }).onError((error, stackTrace) {
      res = false;
      debugPrint("Error is $error");

    });
    return res;
  }

}