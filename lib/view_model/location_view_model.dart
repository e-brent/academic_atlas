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

  String get hours {
    return location.hours;
  }

  String get address {
    return location.address;
  }

  String get image {
    return location.image;
  }

  double get coordNS {
    return location.coordNS;
  }

  double get coordEW {
    return location.coordEW;
  }

  bool get isFavorite{
    return location.isFavorite;
  }

  void setIsFavorite(bool isFavorite)
  {
    location.isFavorite = isFavorite;
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