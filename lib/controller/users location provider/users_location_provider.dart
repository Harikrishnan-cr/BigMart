
import 'dart:developer';

import 'package:geolocator/geolocator.dart';

import 'package:geocoding/geocoding.dart';
import 'package:flutter/cupertino.dart';

class UsersLocationProvider with ChangeNotifier{

String location = 'Chose Location';


Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

 
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
  
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
   
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

 
  return await Geolocator.getCurrentPosition();
}


void convertLocation({required Position data})async{



List<Placemark> placemarks = await placemarkFromCoordinates(data.latitude,data.longitude); 

final val = placemarks[0];  
location = val.subLocality!;   
log('${val.locality}') ; 
log(val.toString()); 
notifyListeners();  
}


}