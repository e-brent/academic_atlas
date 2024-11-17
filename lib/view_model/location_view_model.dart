import 'package:academic_atlas/model/location_model.dart';

class LocationViewModel{
  final Location location;

  LocationViewModel({required this.location});

  int get id {
    return location.id;
  }

  String get name {
    return location.name;
  }
/*
  Map<String, List<double>> get hours {
    return location.hours;
  }
 */

  String get address {
    return location.address;
  }

  String get image {
    return location.image;
  }

  /*
  List<double> get coordinates {
    return location.coordinates;
  }

  List<int> get studySpaces {
    return location.studySpaces;
  }
   */
}