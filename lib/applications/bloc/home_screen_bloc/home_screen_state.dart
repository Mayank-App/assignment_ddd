import '../../../domain/models/wheater_model.dart';

abstract class HomeScreenState {


}
class IntialState extends HomeScreenState{


}
class LoadingState extends HomeScreenState{

}
class LoaderState extends HomeScreenState{
  WeatherModel weatherDetails ;
  LoaderState({required this.weatherDetails});
}

class ErrorState extends HomeScreenState{
  String error;
  ErrorState({required this.error});
}
