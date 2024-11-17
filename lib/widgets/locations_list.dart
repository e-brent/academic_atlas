import 'package:flutter/material.dart';
import 'package:academic_atlas/view_model/location_view_model.dart';

class LocationList extends StatelessWidget {

  final List<LocationViewModel> locations;

  LocationList({required this.locations});

  @override
  Widget build (BuildContext context) {
    return ListView.builder(
      itemCount: locations.length,
      itemBuilder: (context, index) {
        final location = locations[index];

        return ListTile(
          contentPadding: EdgeInsets.all(10),
          leading: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(location.image),
                ),
                borderRadius: BorderRadius.circular(6)
            ),
            width: 50,
            height: 100,
          ),
          title: Text(location.name),
        );
      },
    );
  }
}