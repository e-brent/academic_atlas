import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:academic_atlas/data_service.dart';

import 'package:academic_atlas/view_model/location_view_model.dart';
import 'package:academic_atlas/view_model/study_space_view_model.dart';

import 'package:academic_atlas/model/study_space_model.dart';

class LocationDetailsViewModel extends ChangeNotifier {

  List<StudySpaceViewModel> studyspaces = <StudySpaceViewModel>[];
  List<StudySpaceViewModel> allstudyspaces = <StudySpaceViewModel>[];
  List<StudySpaceViewModel> filteredStudySpaces = <StudySpaceViewModel>[]; //added new list of filtered study spaces for filter view
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

  Future<void> fetchAllStudySpaces() async {
    final results = await Dataservice().fetchAllStudySpaces();

    allstudyspaces =
        results.map((studyspace) => StudySpaceViewModel(studyspace: studyspace))
            .toList();

    notifyListeners();
  }

  Future<void> saveStudySpaces() async {
    List<int> ids = [];
    for(studySpace in studyspaces){
      ids.add(studySpace!.id);
    }

    for (int i = 0; i < studyspaces.length; i++){
      allstudyspaces[ids[i]] = studyspaces[i];
    }

    List<StudySpace> spaces = [];
    for (studySpace in allstudyspaces) {
      spaces.add(studySpace!.studyspace);
    }

    //log("spaces ${spaces.toString()}");
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


  void filterStudySpaces({String? crowdLevel, List<String>? selectedAmenities, bool? showFavs}) {
    filteredStudySpaces = allstudyspaces.where((space) {
      //for crowd level filtering
      if (crowdLevel != null) {
        final selectedLevel = int.tryParse(crowdLevel);
        if (selectedLevel != null && space.crowdLevel > selectedLevel) { //should include all of the levels below the one selected
          return false; //
        }
      }
      //for amenities filtering, should work for if there is one of the amenities selected it will show up, does not have to be all
      if (selectedAmenities != null && selectedAmenities.isNotEmpty) {
        final spaceAmenities = space.currentAmenities.map((a) => a.amenity).toSet();
        final selectedSet = selectedAmenities.toSet();
        if (spaceAmenities.intersection(selectedSet).isEmpty) {
          return false;
        }
      }
      //for the is favorites if we get around to implementing this
      //if (showFavs == true && !space.isFavorite) {
       // return false;
      //}

      return true;
    }).toList();

    notifyListeners();
  }
}