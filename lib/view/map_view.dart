import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pitt Campus Map"),
      ),
        body: Container(
          width: double.infinity,
          height: 600,
          child: FlutterMap(
            options: MapOptions(
              center: LatLng(40.4440, -79.9605), // Center the map over Pitt's campus
              zoom: 14,
          ),
          children: [
            TileLayer( // Display map tiles from any source
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
              userAgentPackageName: 'com.example.app',
              // And many more recommended properties!
            ),
            MarkerLayer(
                markers:[
                  Marker(
                    point: LatLng(40.4440, -79.9532), // Cathedral of Learning
                    width: 40,
                    height: 40,
                    builder: (ctx) => const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                  Marker(
                    point: LatLng(40.4425, -79.9572), // Hillman Library
                    width: 40,
                    height: 40,
                    builder: (ctx) => const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                  Marker(
                    point: LatLng(40.4451, -79.9552), // Petersen Events Center
                    width: 40,
                    height: 40,
                    builder: (ctx) => const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                ],
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
        ),
            ),
        );
      }
      }



