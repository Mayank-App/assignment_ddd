import 'package:assignment_ddd/applications/bloc/search_screen_bloc/search_screen_bloc.dart';
import 'package:assignment_ddd/applications/bloc/search_screen_bloc/search_screen_event.dart';
import 'package:assignment_ddd/applications/bloc/search_screen_bloc/search_screen_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget{
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController text = TextEditingController();
  SearchScreenBloc searchScreenBloc = SearchScreenBloc();
  @override
  Widget build(BuildContext context) {
   return Padding(
     padding: const EdgeInsets.all(8.0),
     child: Column(
       children: [
       TextFormField(
         controller: text ,

         decoration: InputDecoration(
           suffixIcon: InkWell(
             onTap: (){
               searchScreenBloc.add(IntialEvent(cityName: text.text.trim().toString()));
             }
               ,child: Icon(Icons.search)),
           contentPadding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 0.0),
           border: OutlineInputBorder(
             borderSide: BorderSide(
               width: 1,
               color: Colors.black
             )
           )
         ),
       ),
         SizedBox(height: 10,),
         BlocBuilder<SearchScreenBloc,SearchScreenState>(
           bloc: searchScreenBloc,
           builder: (BuildContext context, SearchScreenState state){
           if(state is LoadingState){
             return Center(child: CircularProgressIndicator());
           }
           else if(state is LoaderState){
             return  Column(
               children: [
                 rowItem("name :",state.weatherDetails.name.toString()),
                 rowItem("Humidity :",state.weatherDetails.main!.humidity.toString()),
                 rowItem("Preasure :",state.weatherDetails.main!.pressure.toString()),
                 rowItem("TempMin :",state.weatherDetails.main!.tempMin.toString()),
                 rowItem("TempMax :",state.weatherDetails.main!.tempMax.toString()),
                 rowItem("TempMax :",state.weatherDetails.main!.temp.toString()),

               ],
             );

           }
           else if(state is ErrorState){
             return Text(state.error.toString());
           }
           else{
             return Container();
           }
         },

         )

       ],
     ),
   );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    text.clear();
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
}