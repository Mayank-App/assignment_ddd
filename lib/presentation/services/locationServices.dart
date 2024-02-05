import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';


String myCity = "";
class LocationService {
  static Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();


    if (permission == LocationPermission.denied) {
      debugPrint("Denied Permission");
      LocationPermission ask = await Geolocator.requestPermission();
    } else if (permission == LocationPermission.deniedForever) {
      debugPrint("Permanent denied");
      Geolocator.openAppSettings();
    } else {
      debugPrint("Permitted");
      Position currentposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      getAddressFromLatLng(currentposition);
      debugPrint(currentposition.latitude.toString());
      debugPrint(currentposition.altitude.toString());
      // Do something with the current location if needed
    }
  }
  static Future<void> getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      debugPrint("Address : ${place.locality}");
      if(placemarks.isNotEmpty){
        myCity = place.locality!;
      }
      else{
        myCity = "Noida";
      }

    }).catchError((e) {
      debugPrint(e);
    });
  }
}

