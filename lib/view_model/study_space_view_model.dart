import 'package:academic_atlas/model/study_space_model.dart';
import 'package:flutter/cupertino.dart';
import 'dart:developer';

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
    double newCrowd = (studyspace.crowdLevel + crowd)/2;
    studyspace.crowdLevel = newCrowd;
  }

  void setCrowdLevel(double crowd){
    studyspace.crowdLevel = crowd;
  }

  List<Amenities> get currentAmenities{
    return studyspace.currentAmenities;
  }

  void addCurrentAmenities(String amenity){
    Amenities newAmenity = Amenities(amenity: amenity);
    currentAmenities.add(newAmenity);
  }

  void removeCurrentAmenities(String amenity){
    //Amenities oldAmenity = Amenities(amenity: amenity);
    //currentAmenities.remove(oldAmenity);

    currentAmenities.removeWhere((currAmenity) => currAmenity.amenity == amenity);
  }

  List<Amenities> get generalAmenities{
    return studyspace.generalAmenities;
  }

  List<Map<String,String>> get reviews{
    return studyspace.reviews;
  }

  void addReview(Map<String, String> review){
    reviews.add(review);
  }
}