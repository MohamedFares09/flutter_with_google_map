import 'package:location/location.dart';

class LocationServers {
  final Location location = Location();
  Future<void> checkAndRequsetLocationServices() async {
    bool isChecked = await location.serviceEnabled();
    if (!isChecked) {
      isChecked = await location.requestService();
      if (!isChecked) {
        throw LocationServerException();
      }
    }
  }

  Future<void> checkAndRequsetLocationPermission() async {
    var permision = await location.hasPermission();
    if (permision == PermissionStatus.deniedForever) {
      throw LocationServerException();
    }
    if (permision == PermissionStatus.denied) {
      permision = await location.requestPermission();
      if (permision == PermissionStatus.denied) {
        throw LocationPermissionException();
      }
    }
    
  }

  void getRealTimeLocation(void Function(LocationData) onData)async {
    await checkAndRequsetLocationServices();
    await checkAndRequsetLocationPermission();
    location.onLocationChanged.listen(onData);
  }

  Future<LocationData> getLocation() async {
    await checkAndRequsetLocationServices();
    await checkAndRequsetLocationPermission();
    return await location.getLocation();
  }
}

class LocationServerException implements Exception {}

class LocationPermissionException implements Exception {}
