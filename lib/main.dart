import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_google_maps/firebase_options.dart';
import 'package:flutter_with_google_maps/google_maps_view.dart';


void main() { 
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const RouteTrakerApp());
}

class RouteTrakerApp extends StatelessWidget {
  const RouteTrakerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: GoogleMapsView());
  }
}
