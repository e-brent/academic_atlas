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

  Future<List<StudySpace>> fetchStudySpaces(int locationID) async {

    final String reponse = await rootBundle.loadString('assets/studyspace_data.json');

    final data = await jsonDecode(reponse);

    final Iterable json = data["studyspaces"];

    final List allstudyspaces = json.map((studyspace) => StudySpace.fromJson(studyspace)).toList();

    List<StudySpace> studyspaces = [];
    for (var i = 0; i < allstudyspaces.length; i++){
      if (allstudyspaces[i]["location"] == locationID){
        studyspaces.add(allstudyspaces[i]);
      }
    }

    return studyspaces;
  }

  Future<List<User>> fetchUsers() async {
    final String response = await rootBundle.loadString('assets/user_data.json');

    final data = await jsonDecode(response);

    final Iterable json = data["users"];

    return json.map((user) => User.fromJson(user)).toList();
  }
}