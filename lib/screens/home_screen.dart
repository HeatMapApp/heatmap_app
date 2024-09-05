import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:heatmap_app/components/action_button.dart';
import 'package:heatmap_app/components/profile_button.dart';
import 'package:heatmap_app/components/ranking_button.dart';
import 'package:heatmap_app/screens/temp_rater.dart';
import 'package:latlong2/latlong.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MapController _controller = MapController();
  Position? currentLocation;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    print("Checking if location services are enabled...");

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, handle it here.
      print("Location services are disabled.");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, handle it here.
        print("Location permissions are denied.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle it here.
      print("Location permissions are permanently denied.");
      return;
    }

    // If we reach here, permissions are granted and we can fetch the location.
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      currentLocation = position;
    });

    // Move the map to the user's current location
    _controller.move(
      LatLng(currentLocation!.latitude, currentLocation!.longitude),
      15, // Adjust zoom level as needed
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: _controller,
          options: const MapOptions(
            initialCenter: LatLng(1.2878, 103.866666), // Default location
            initialZoom: 13,
          ),
          children: [
            openStreetMapTileLater,
            CurrentLocationLayer(),
          ],
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: ActionButton(
                text: 'Rate Your Temp!',
                icon: const Icon(Icons.thermostat, color: Colors.white),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TempRater()),
                  );
                },
              ),
            ),
          ),
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              onPressed:
                  _getCurrentLocation, // Fetch and move to current location
              icon: const Icon(Icons.location_pin),
            ),
          ),
        ),
        const SafeArea(
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: ProfileButton(
                imageUrl:
                    'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg',
              ),
            ),
          ),
        ),
        const SafeArea(
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: RankingButton(number: '99+'),
            ),
          ),
        )
      ],
    );
  }
}

TileLayer get openStreetMapTileLater => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    );
