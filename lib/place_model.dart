import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng latLng;
  PlaceModel({required this.id, required this.name, required this.latLng});
}

List<PlaceModel> places = [
  PlaceModel(
    id: 1,
    name: 'كفور بلشاي',
    latLng: LatLng(30.8552799355311, 30.802008837200024),
  ),
  PlaceModel(
    id: 2,
    name: 'النحاريه',
    latLng: LatLng(30.874646852660362, 30.832212430173094),
  ),
];
