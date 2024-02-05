
import 'package:hive/hive.dart';

part 'save.g.dart';


@HiveType(typeId: 0)
class SaveData {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final int humidity;
  @HiveField(2)
  final double? temp;
  @HiveField(3)
  final int pressure;
  @HiveField(4)
  final double tempMin;
  @HiveField(5)
  final double tempMax;

  SaveData({
    required this.name,
    required this.humidity,
    required this.pressure,
    required this.tempMin,
    required this.tempMax,
    required this .temp
  });

  // Factory method to create a WeatherData instance from a JSON map
  factory SaveData.fromJson(Map<String, dynamic> json) {

    return SaveData(
      name: json['name'] ?? 0, // Default to 0 if 'timezone' is missing
      humidity: json['main']['humidity'] ?? 0, // Default to 0 if 'humidity' is missing
      temp: json['main']['temp']??0,
      pressure: json['main']['pressure'] ?? 0, // Default to 0 if 'pressure' is missing
      tempMin: (json['main']['temp_min'] ?? 0.0).toDouble(),
      tempMax: (json['main']['temp_max'] ?? 0.0).toDouble(),
    );
  }
}
