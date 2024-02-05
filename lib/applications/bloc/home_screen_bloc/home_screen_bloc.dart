import 'dart:async';
import 'dart:convert';

import 'package:assignment_ddd/applications/bloc/home_screen_bloc/home_screen_event.dart';
import 'package:assignment_ddd/applications/bloc/home_screen_bloc/home_screen_state.dart';
import 'package:assignment_ddd/domain/models/save.dart';
import 'package:assignment_ddd/domain/models/wheater_model.dart';
import 'package:assignment_ddd/domain/reposistory/weather_reposistory.dart';
import 'package:assignment_ddd/infrastructure/db_resouces/local_db_services/local_db.dart';
import 'package:assignment_ddd/presentation/services/locationServices.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

class HomeScreenBloc extends Bloc<HomeScreenBlocEvent,HomeScreenState>{
  WeatherReposistory weatherReposistory = WeatherReposistory();
  final box = Boxes.getData();
  List<SaveData> saveData = [];
  HomeScreenBloc():super(IntialState()){
    on<IntialEvent>(weatherDetails);
  }

  FutureOr<void> weatherDetails(IntialEvent event, Emitter<HomeScreenState> emit) async{
    try{
      emit(LoadingState());
      Map<String, dynamic> data = await weatherReposistory.getApi(myCity);
      WeatherModel weatherDetails = WeatherModel.fromJson(data);
      saveData.add(SaveData.fromJson(data));
       debugPrint("${saveData[0].humidity}");
         box.put("data save", saveData);
       emit(LoaderState(weatherDetails: weatherDetails));
      }
    catch(error){
       emit(ErrorState( error: error.toString(),));
    }
  }
}