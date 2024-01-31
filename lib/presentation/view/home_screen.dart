import 'package:assignment_ddd/domain/reposistory/weather_reposistory.dart';
import 'package:assignment_ddd/utils/routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       actions: [
         InkWell(
             onTap: () async{
           await  FirebaseAuth.instance.signOut();
           Navigator.pushNamed(context,RoutesName.login);
             },
             child: Icon(Icons.logout))
       ],
     ),
     body: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           ElevatedButton(onPressed: (){
             WeatherReposistory().getApi();

           }, child:Text("Tap to getData"))
         ],
       ),
     ),
   );
  }
}