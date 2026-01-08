import 'package:flutter/material.dart';
import 'package:flutter_with_google_maps/utlis/location_servers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsView extends StatefulWidget {
  const GoogleMapsView({super.key});

  @override
  State<GoogleMapsView> createState() => _GoogleMapsViewState();
}

class _GoogleMapsViewState extends State<GoogleMapsView> {
  late CameraPosition cameraPosition;
  late LocationServers locationServers;
  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  @override
  void initState() {
    locationServers = LocationServers();
    cameraPosition = CameraPosition(target: LatLng(0, 0));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: markers,
        onMapCreated: (controller) {
          googleMapController = controller;
          updateCurrentLocation();
        },
        zoomControlsEnabled: false,
        initialCameraPosition: cameraPosition,
      ),
    );
  }

  void updateCurrentLocation() async {
    try {
      var locationData = await locationServers.getLocation();
      LatLng currentPostion = LatLng(
        locationData.latitude!,
        locationData.longitude!,
      );
      CameraPosition myLocationCameraPostion = CameraPosition(
        target: currentPostion,
        zoom: 16,
      );
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(myLocationCameraPostion),
      );
      Marker myLocationMarker = Marker(
        markerId: MarkerId('my location marker'),
        position: currentPostion,
      );
      markers.add(myLocationMarker);
      setState(() {});
    } on LocationServerException catch (e) {
      // TODO
    } on LocationPermissionException catch (e) {
    } catch (e) {
      // TODO
    }
  }
}
