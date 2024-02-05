
import 'dart:async';

import 'package:assignment_ddd/applications/bloc/search_screen_bloc/search_screen_event.dart';
import 'package:assignment_ddd/applications/bloc/search_screen_bloc/search_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/wheater_model.dart';
import '../../../domain/reposistory/weather_reposistory.dart';

class SearchScreenBloc extends Bloc<SearchScreenBlocEvent,SearchScreenState>{
  WeatherReposistory weatherReposistory = WeatherReposistory();
  SearchScreenBloc():super(IntialState()){
    on<IntialEvent>(searchData);
  }

  FutureOr<void> searchData(IntialEvent event, Emitter<SearchScreenState> emit) async{
    try{
      emit(LoadingState());
       Map<String, dynamic> data = await weatherReposistory.getApi(event.cityName);
       WeatherModel weatherDetails = WeatherModel.fromJson(data);
      // saveData.add(SaveData.fromJson(data));
      //   debugPrint("${saveData[0].humidity}");
      //     box.put("data save", saveData);
        emit(LoaderState(weatherDetails: weatherDetails));
      }
     catch(error){
      emit(ErrorState( error: "No result found"));
}
  }
  }

