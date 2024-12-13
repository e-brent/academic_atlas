import 'package:flutter/material.dart';
import 'package:academic_atlas/data_service.dart';
import 'package:academic_atlas/view_model/location_view_model.dart';

class LocationListViewModel extends ChangeNotifier {
  List<LocationViewModel> locations = <LocationViewModel>[];
  LocationViewModel? location;

  Future<void> fetchLocations() async {
    final results = await Dataservice().fetchLocations();

    locations = results.map((location) => LocationViewModel(location: location)).toList();

    notifyListeners();
  }

  List<String> getLocationNames() {
    List<String> locationNames = [];
    for (location in locations) {
      locationNames.add(location!.name);
    }
    return locationNames;
  }
}