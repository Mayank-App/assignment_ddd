import '../../../domain/models/wheater_model.dart';

abstract class SearchScreenState {


}
class IntialState extends SearchScreenState {


}
class LoadingState extends SearchScreenState {

}
class LoaderState extends SearchScreenState {
  WeatherModel weatherDetails ;
  LoaderState({required this.weatherDetails});
}

class ErrorState extends SearchScreenState {
  String error;
  ErrorState({required this.error});
}
