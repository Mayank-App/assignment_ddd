import 'package:assignment_ddd/applications/bloc/connectivity_bloc/state.dart';
import 'package:assignment_ddd/applications/bloc/home_screen_bloc/home_screen_bloc.dart';
import 'package:assignment_ddd/applications/bloc/home_screen_bloc/home_screen_event.dart';
import 'package:assignment_ddd/applications/bloc/home_screen_bloc/home_screen_state.dart';
import 'package:assignment_ddd/presentation/view/searchScreen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../applications/bloc/connectivity_bloc/bloc.dart';
import '../../domain/models/save.dart';
import '../../domain/models/wheater_model.dart';
import '../../utils/routes/routes_imports.gr.dart';

@RoutePage()
class HomeScreen extends StatefulWidget{
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeScreenBloc homeScreenBloc = HomeScreenBloc();
  InternetBloc internetBloc = InternetBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeScreenBloc.add(IntialEvent());
  }
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
   return DefaultTabController(
     initialIndex: 1,
     length: 2,
     child: Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.blue,
         bottom: TabBar(
           tabs: [
             Tab(
               icon: Icon(Icons.home,color: Colors.black,size: 30,),
             ),
             Tab(
               icon: Icon(Icons.search,color: Colors.black,size: 30),
             ),
           ],
         ),
         actions: [
           InkWell(
               onTap: () async{
             await  FirebaseAuth.instance.signOut();
             AutoRouter.of(context).push( const SignInScreenRoute() );
               },
               child: const Icon(Icons.logout)),
         ],

     automaticallyImplyLeading: false,
       ),
       body: TabBarView(
         children: [
           Column(
             children: [
               BlocBuilder<InternetBloc,InternetState>(
                 //bloc: internetBloc,
                 builder: (BuildContext context, InternetState state) {
                   if(state is InternetLossedState){
                     final data = state.box;
                     return uiScreen(data,size);
                   }
                   else if (state is InternetGainedState){
                     return  Column(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       //  mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         BlocBuilder<HomeScreenBloc,HomeScreenState>(
                           bloc: homeScreenBloc,
                           builder: (BuildContext context, HomeScreenState state) {
                             if(state is LoadingState){
                               return const CircularProgressIndicator();
                             }
                             else if (state is LoaderState){
                               final data = state.weatherDetails;
                               return uiScreenInternet(data, size);
                             }
                             else if(state is ErrorState){
                               return Text(state.error.toString());
                             }
                             else{
                               return Container();
                             }
                           },)

                       ],
                     );


                   }
                   else{
                     return Container(
                       height: 50,
                       width: 50,
                       color: Colors.blueAccent,
                     );
                   }
                 },),
             ],
           ),
           SearchScreen()
         ],
       )
     ),
   );
  }
  Widget rowItem (String nameA , String nameB){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(nameA),
        Text(nameB)
      ],
    );
  }
  Widget uiScreen( List<SaveData> data,Size size){
   return Container(
     decoration: const BoxDecoration(
       gradient: LinearGradient(
         begin: Alignment.topLeft,
         end: Alignment.bottomRight,
         colors: [Colors.blue, Colors.purple],
       ),
     ),
     child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: size.height*0.03,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Welcome back !",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: Colors.white),),
                Row(
                  children: [
                    const Icon(Icons.location_city,color: Colors.orange),
                    Text(data[0].name.toString(),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                  ],
                ),
                //  SizedBox(height: size.height*0.1,),
                Center(
                    child: Image.asset("assets/images/wheather.webp")
                ),
              ],
            ),
     
         //   SizedBox(height: size.height*0.1113,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8 ),
              child: Column(
                children: [
                  Text("Temperature : ${data[0].temp.toString()}\u2103",style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
                  SizedBox(height: size.height*0.02,),
                  const Divider(
                    height: 20,
                    thickness: 2,
                    indent: 0,
                    endIndent: 0,
                  ),
                  SizedBox(height: size.height*0.02,),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Min Temp ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),
                              Text("${data[0].tempMin.toString()}\u2103",style: const TextStyle(fontSize: 14,color: Colors.white),),
                            ],
                          ),
     
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Pressure",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),
                              Text("${data[0].pressure.toString()}",style: const TextStyle(fontSize: 14,color: Colors.white),),
                            ],
                          ),
                        ],
                      ),
     
                      SizedBox(height: size.height*0.015,),
     
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Max Temp",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),
                              Text("${data[0].tempMax.toString()}\u2103",style: const TextStyle(fontSize: 14,color: Colors.white),),
                            ],
                          ),
     
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Humidity",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),
                              Text("${data[0].humidity.toString()}",style: const TextStyle(fontSize: 14,color: Colors.white),),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
     
          ],
        ),
      ),
   );
  }
  Widget uiScreenInternet(WeatherModel weatherDetails,Size size){
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.purple],
          ),
        ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: size.height*0.03,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Welcome back !",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: Colors.white),),
                Row(
                  children: [
                    const Icon(Icons.location_city,color: Colors.orange),
                    Text(weatherDetails.name.toString(),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                  ],
                ),
                //  SizedBox(height: size.height*0.1,),
                Center(
                    child: Image.asset("assets/images/wheather.webp")
                ),
              ],
            ),

            SizedBox(height: size.height*0.055,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8 ),
              child: Column(
                children: [
                  Text("Temperature : ${weatherDetails.main!.temp.toString()}\u2103",style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
                  SizedBox(height: size.height*0.02,),
                  const Divider(
                    height: 20,
                    thickness: 2,
                    indent: 0,
                    endIndent: 0,
                  ),
                  SizedBox(height: size.height*0.02,),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Min Temp ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),
                              Text("${weatherDetails.main!.tempMin.toString()}\u2103",style: const TextStyle(fontSize: 14,color: Colors.white),),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Pressure",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),
                              Text("${weatherDetails.main!.pressure.toString()}",style: const TextStyle(fontSize: 14,color: Colors.white),),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: size.height*0.015,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Max Temp",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),
                              Text("${weatherDetails.main!.tempMax.toString()}\u2103",style: const TextStyle(fontSize: 14,color: Colors.white),),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Humidity",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),
                              Text("${weatherDetails.main!.humidity.toString()}",style: const TextStyle(fontSize: 14,color: Colors.white),),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );

  }
}