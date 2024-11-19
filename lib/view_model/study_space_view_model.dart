import 'package:academic_atlas/model/study_space_model.dart';

class StudySpaceViewModel{
  final StudySpace studyspace;

  StudySpaceViewModel({required this.studyspace});

  int get id {
    return studyspace.id;
  }

  String get name {
    return studyspace.name;
  }

  int get location {
    return studyspace.location;
  }

  double get crowdLevel {
    return studyspace.crowdLevel;
  }

  set crowdLevel(double crowd){
    crowdLevel = (crowdLevel + crowd)/2;
  }

  List<Amenities> get currentAmenities{
    return studyspace.currentAmenities;
  }

  void setCurrentAmenities(String amenity){
    Amenities newAmenity = Amenities(amenity: amenity);
    currentAmenities.add(newAmenity);
  }

  List<Amenities> get generalAmenities{
    return studyspace.generalAmenities;
  }
}