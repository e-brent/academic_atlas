import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:academic_atlas/view/filter_view.dart';
import 'package:academic_atlas/view/search_view.dart';
import 'package:academic_atlas/view/location_detail_view.dart';

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
        title: Text("Pitt Academic Atlas", style: TextStyle(color: Colors.deepPurple.shade900.withBlue(80))),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SearchView()), );
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => const FilterView()), );
            },
          ),
        ],
        backgroundColor: Colors.purple.shade100,
        elevation: 10,
        shadowColor: Colors.black,
      ),
        body: Container(
          width: double.infinity,
          height: 600,
          child: FlutterMap(
            options: MapOptions(
              center: LatLng(40.4426, -79.9564), // Center the map over Pitt's campus
              zoom: 16,
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
                    point: LatLng(40.4440, -79.9532), //cathy
                    width: 40,
                    height: 40,
                    builder: (ctx) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LocationDetailsView(2),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  ),
                  Marker(
                    point: LatLng(40.4426, -79.9542), // Hillman Library
                    width: 40,
                    height: 40,
                    builder: (ctx) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LocationDetailsView(0),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  ),
                  Marker(
                    point: LatLng(40.4414, -79.9560), //  Sennott
                    width: 40,
                    height: 40,
                    builder: (ctx) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LocationDetailsView(3),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  ),
                  Marker(
                    point: LatLng(40.4423, -79.9553), //Lawrence Hall
                    width: 40,
                    height: 40,
                    builder: (ctx) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LocationDetailsView(4),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  ),
                  Marker(
                    point: LatLng(40.4436, -79.9545), //wpu
                    width: 40,
                    height: 40,
                    builder: (ctx) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LocationDetailsView(5),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  ),
                  Marker(
                    point: LatLng(40.4438, -79.9584), //benedum
                    width: 40,
                    height: 40,
                    builder: (ctx) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LocationDetailsView(6),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  ),
                  Marker(
                    point: LatLng(40.4453, -79.9540), //alumni
                    width: 40,
                    height: 40,
                    builder: (ctx) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LocationDetailsView(7),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  ),
                  Marker(
                    point: LatLng(40.4416, -79.9537), // Posvar Hall
                    width: 40,
                    height: 40,
                    builder: (ctx) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LocationDetailsView(1),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 30,
                      ),
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



