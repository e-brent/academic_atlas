import 'dart:convert';
import 'package:flutter/services.dart';

import 'dart:developer';
import 'package:academic_atlas/file_manager.dart';

import 'package:academic_atlas/model/user_model.dart';
import 'package:academic_atlas/model/location_model.dart';
import 'package:academic_atlas/model/study_space_model.dart';

class Dataservice {

  Future<List<Location>> fetchLocations() async {
    //final String response = await rootBundle.loadString('assets/location_data.json');
    final String response = await FileManager().readLocationFile();

    final data = await jsonDecode(response);

    //log("data ${data.toString()}");

    final Iterable json = data["locations"];

    return json.map((location) => Location.fromJson(location)).toList();
  }

  Future<Location> fetchLocation(int id) async {
    //final String response = await rootBundle.loadString('assets/location_data.json');
    final String response = await FileManager().readLocationFile();

    final data = await jsonDecode(response);

    final Iterable json = data["locations"];

    final List allLocations = json.map((location) => Location.fromJson(location)).toList();

    return allLocations[id];
  }

  Future<List<StudySpace>> fetchAllStudySpaces() async {

    //final String response = await rootBundle.loadString('assets/studyspace_data.json');
    final String response = await FileManager().readStudySpaceFile();

    final data = await jsonDecode(response);

    //log("all study space data ${data.toString()}");

    final Iterable json = data["studyspaces"]; //

    final List<StudySpace> allstudyspaces = json.map((studyspace) => StudySpace.fromJson(studyspace)).toList();
    //log(allstudyspaces.toString());

    return allstudyspaces;
  }

  Future<List<StudySpace>> fetchStudySpaces(int locationID) async {

    //final String response = await rootBundle.loadString('assets/studyspace_data.json');
    final String response = await FileManager().readStudySpaceFile();

    final data = await jsonDecode(response);

    //log("data ${data.toString()}");

    final Iterable json = data["studyspaces"]; //

    final List allstudyspaces = json.map((studyspace) => StudySpace.fromJson(studyspace)).toList();

    List<StudySpace> studyspaces = [];
    for (StudySpace space in allstudyspaces) {
      if (space.location == locationID) {
        studyspaces.add(space);
      }
    }

    return studyspaces;
  }

  Future<StudySpace> fetchStudySpace(int id) async {
    //final String response = await rootBundle.loadString('assets/studyspace_data.json');
    final String response = await FileManager().readStudySpaceFile();

    final data = await jsonDecode(response);

    final Iterable json = data["studyspaces"]; //

    final List allStudySpaces = json.map((studyspace) => StudySpace.fromJson(studyspace)).toList();

    //log('id ${id.toString()}');
    //log(allStudySpaces[id].toString());

    return allStudySpaces[id];
  }

  Future<void> saveLocations(List<Location> locations) async {
    await FileManager().writeLocationFile({"locations" : locations});
  }

  Future<void> saveStudySpaces(List<StudySpace> studyspaces) async {
    await FileManager().writeStudySpaceFile({"studyspaces" : studyspaces});
  }

  Future<List<User>> fetchUsers() async {
    final String response = await rootBundle.loadString('assets/user_data.json');

    final data = await jsonDecode(response);

    final Iterable json = data["users"];

    return json.map((user) => User.fromJson(user)).toList();
  }
}