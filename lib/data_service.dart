import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:academic_atlas/model/user_model.dart';
import 'package:academic_atlas/model/location_model.dart';
import 'package:academic_atlas/model/study_space_model.dart';

class Dataservice {

  Future<List<Location>> fetchLocations() async {
    final String response = await rootBundle.loadString('assets/location_data.json');

    final data = await jsonDecode(response);

    final Iterable json = data["locations"];

    return json.map((location) => Location.fromJson(location)).toList();
  }

  Future<Location> fetchLocation(int id) async {
    final String response = await rootBundle.loadString('assets/location_data.json');

    final data = await jsonDecode(response);

    final Iterable json = data["locations"];

    final List allLocations = json.map((location) => Location.fromJson(location)).toList();

    return allLocations[id];
  }

  Future<List<StudySpace>> fetchStudySpaces(int locationID) async {

    final String response = await rootBundle.loadString('assets/studyspace_data.json');

    final data = await jsonDecode(response);

    final Iterable json = data["studyspaces"];

    final List allstudyspaces = json.map((studyspace) => StudySpace.fromJson(studyspace)).toList();

    List<StudySpace> studyspaces = [];
    for (StudySpace space in allstudyspaces){
      if (space.location == locationID){
        studyspaces.add(space);
      }
    }

    return studyspaces;
  }

  Future<StudySpace> fetchStudySpace(int id) async {
    final String response = await rootBundle.loadString('assets/studyspace_data.json');

    final data = await jsonDecode(response);

    final Iterable json = data["studyspaces"];

    final List allStudySpaces = json.map((studyspace) => StudySpace.fromJson(studyspace)).toList();

    return allStudySpaces[id];
  }

  Future<void> saveStudySpace(int id) async {
    final StudySpace space =  await fetchStudySpace(id);
  }

  Future<List<User>> fetchUsers() async {
    final String response = await rootBundle.loadString('assets/user_data.json');

    final data = await jsonDecode(response);

    final Iterable json = data["users"];

    return json.map((user) => User.fromJson(user)).toList();
  }
}