import 'package:academic_atlas/model/study_space_model.dart';
import 'package:flutter/cupertino.dart';

class StudySpaceViewModel extends ChangeNotifier{
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
    studyspace.crowdLevel = crowd;
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

  List<Amenities> get reviews{
    return studyspace.generalAmenities;
  }
}