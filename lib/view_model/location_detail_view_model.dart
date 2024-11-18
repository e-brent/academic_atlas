import 'package:academic_atlas/model/location_model.dart';

class LocationDetailsViewModel {

  final Location location;

  LocationDetailsViewModel({required this.location});

  String get name {
    return location.name;
  }


}