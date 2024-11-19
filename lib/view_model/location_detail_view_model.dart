import 'package:flutter/material.dart';
import 'package:academic_atlas/data_service.dart';
import 'package:academic_atlas/view_model/location_view_model.dart';
import 'package:academic_atlas/view_model/study_space_view_model.dart';

class LocationDetailsViewModel extends ChangeNotifier{

  List<StudySpaceViewModel> studyspaces = <StudySpaceViewModel>[];
  LocationViewModel? location;
  StudySpaceViewModel? studySpace;

  Future<void> fetchStudySpaces(int id) async {
    final results = await Dataservice().fetchStudySpaces(id);

    studyspaces = results.map((studyspace) => StudySpaceViewModel(studyspace: studyspace)).toList();

    notifyListeners();
  }

  Future<void> fetchLocation(int id) async {
    final results = await Dataservice().fetchLocation(id);

    location = LocationViewModel(location: results);

    notifyListeners();
  }

  List<String> getStudySpaceNames(int id) {
    List<String> spaceNames = [];
    for (studySpace in studyspaces){
      spaceNames.add(studySpace!.name);
    }
    return spaceNames;
  }
}