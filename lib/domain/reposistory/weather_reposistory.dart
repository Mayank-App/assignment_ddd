import 'package:assignment_ddd/infrastructure/db_resouces/network_services/api_services.dart';
import 'package:flutter/cupertino.dart';

class WeatherReposistory {
  ApiServices apiServices = ApiServices();

   getApi() async{
    try {
      var response = await apiServices.call("https://api.openweathermap.org/data/2.5/weather",queryParameters: {
        "q":"Gorakhpur",
        "appid":"ba48a98c7dd69a60c33f11dec0038fe4",
        "units":"metric"
      });
      debugPrint("$response");
      //return response;
    }
    catch (e)
    {
      rethrow;
    }

  }
}