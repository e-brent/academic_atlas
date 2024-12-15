import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:academic_atlas/data_service.dart';

import 'package:academic_atlas/view_model/location_view_model.dart';
import 'package:academic_atlas/view_model/study_space_view_model.dart';

import 'package:academic_atlas/model/study_space_model.dart';

class LocationDetailsViewModel extends ChangeNotifier {

  List<StudySpaceViewModel> studyspaces = <StudySpaceViewModel>[];
  LocationViewModel? location;
  StudySpaceViewModel? studySpace;

  Future<void> fetchStudySpaces(int id) async {
    final results = await Dataservice().fetchStudySpaces(id);

    studyspaces =
        results.map((studyspace) => StudySpaceViewModel(studyspace: studyspace))
            .toList();

    notifyListeners();
  }

  Future<void> fetchLocation(int id) async {
    final results = await Dataservice().fetchLocation(id);

    location = LocationViewModel(location: results);

    notifyListeners();
  }

  int getLocationId() {
    return location!.id;
  }

  Future<void> fetchStudySpace(int id) async {
    final results = await Dataservice().fetchStudySpace(id);

    studySpace = StudySpaceViewModel(studyspace: results);

    notifyListeners();

  }

  Future<void> saveStudySpaces() async {
    List<StudySpace> spaces = [];
    for (studySpace in studyspaces) {
      spaces.add(studySpace!.studyspace);
    }

    Dataservice().saveStudySpaces(spaces);
  }

  List<String> getStudySpaceNames(int id) {
    List<String> spaceNames = [];
    for (studySpace in studyspaces) {
      spaceNames.add(studySpace!.name);
    }
    //log('getting studyspace names...');
    return spaceNames;
  }

  List<int> getStudySpaceIds(int id) {
    List<int> spaceIds = [];
    for (studySpace in studyspaces) {
      spaceIds.add(studySpace!.id);
    }
    return spaceIds;
  }

  int getStudySpaceID() {
    return studySpace!.id;
  }

  double getCrowdLevel(int id) {
    return studyspaces[id].crowdLevel;
  }

  void setCrowdLevel(int id, double newCrowd) {
    log("setting crowd level for ${studyspaces[id].name}");
    studyspaces[id].crowdLevel = newCrowd;
    log(studyspaces[id].crowdLevel.toString());

    saveStudySpaces();

    notifyListeners();
  }

  List<String> getCurrentAmenities(int id) {
    //String log = studyspaces[id].currentAmenities[0].amenity;
    //return log;
    return studyspaces[id].currentAmenities.map((amenity) => amenity.amenity).toList();
  }

  void addCurrentAmenities(int id, List<String> newAmenities) {

    //log("setting current amenities");

    for (int i = 0; i < newAmenities.length; i++){
      studyspaces[id].addCurrentAmenities(newAmenities[i]);
    }

    saveStudySpaces();

    notifyListeners();
  }

  void removeCurrentAmenities(int id, List<String> oldAmenities){
    for (int i = 0; i < oldAmenities.length; i++){
      studyspaces[id].removeCurrentAmenities(oldAmenities[i]);
    }

    saveStudySpaces();

    notifyListeners();
  }

  List<String> getStaticAmenities(int id) {
    //String log = studyspaces[id].currentAmenities[0].amenity;
    //return log;
    return studyspaces[id].generalAmenities.map((amenity) => amenity.amenity).toList();
  }

  List<Map<String, String>> getReviews(int id){
    return studyspaces[id].reviews;
  }

  void addReview(int id, Map<String, String> review){
    studyspaces[id].addReview(review);

    saveStudySpaces();

    notifyListeners();
  }
}