import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleEx extends StatefulWidget {
  const GoogleEx({super.key});

  @override
  State<GoogleEx> createState() => _GoogleExState();
}

class _GoogleExState extends State<GoogleEx> {
  late CameraPosition cameraPosition;
  late Location location;
  Set<Marker> markers = {};
  @override
  void initState() {
    cameraPosition = CameraPosition(
      zoom: 17,
      target: LatLng(37.7749, -122.4194),
    );
    location = Location();
    upDataLocation();
    super.initState();
  }

  GoogleMapController? mapController;
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      markers: markers,
      onMapCreated: (controller) {
        mapController = controller;
        initMapStyle();
      },
      initialCameraPosition: cameraPosition,
    );
  }

  void initMapStyle() async {
    final mapStyle = await rootBundle.loadString('assets/map_style.json');
    mapController!.setMapStyle(mapStyle);
  }

  Future<void> checkAndRequsetLocationServices() async {
    bool isChecked = await location.serviceEnabled();
    if (!isChecked) {
      isChecked = await location.requestService();
      if (!isChecked) {
        return;
      }
    }
  }

  Future<bool> checkAndRequsetLocationPermission() async {
    var permision = await location.hasPermission();
    if (permision == PermissionStatus.deniedForever) {
      return false;
    }
    if (permision == PermissionStatus.denied) {
      permision = await location.requestPermission();
      if (permision != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  void locationDate() {
    location.changeSettings(
      distanceFilter: 2,
    );
    location.onLocationChanged.listen((locationData) {
      var cameraPosition = CameraPosition(
        zoom: 17,
        target: LatLng(locationData.latitude!, locationData.longitude!),
      );
      var my_marker = Marker(
        markerId: MarkerId('my_marker'),
        position: LatLng(locationData.latitude!, locationData.longitude!),
      );
      markers.add(my_marker);
      setState(() {});
      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition),
      );
    });
  }

  void upDataLocation() async {
    await checkAndRequsetLocationServices();
    var hasPermision = await checkAndRequsetLocationPermission();
    if (hasPermision) {
      locationDate();
    }
  }
}
