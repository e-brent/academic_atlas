import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  //final MapController _controller = MapController();

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(40.4440, -79.9605), // Center the map over Pitt's campus
        initialZoom: 9.2,
      ),
      children: [
        TileLayer( // Display map tiles from any source
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
          userAgentPackageName: 'com.example.app',
          // And many more recommended properties!
        ),
        RichAttributionWidget( // Include a stylish prebuilt attribution widget that meets all requirements
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')), // (external)
            ),
            // Also add images...
          ],
        ),
      ],
    );
  }
  }



