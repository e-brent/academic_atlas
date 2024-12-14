import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'dart:developer';


import 'package:academic_atlas/model/user_model.dart';
import 'package:academic_atlas/model/location_model.dart';
import 'package:academic_atlas/model/study_space_model.dart';

const initialLocations = 'assets/location_data.json';
const initialStudySpaces = 'assets/studyspace_data.json';

class FileManager {
  static FileManager? _instance;

  FileManager._internal() {
    _instance = this;
  }

  factory FileManager() => _instance ?? FileManager._internal();

  Future<String> get _directoryPath async {
    Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _locationFile async {
    final path = await _directoryPath;
    final locationFile = File('$path/location_data.json');

    if (!await locationFile.exists()){
      final initialContent = await rootBundle.loadString(initialLocations);
      await locationFile.create();
      await locationFile.writeAsString(initialContent);
    }
    return locationFile;
  }

  Future<File> get _studySpaceFile async {
    final path = await _directoryPath;
    final studySpaceFile = File('$path/studyspace_data.json');

    if (!await studySpaceFile.exists()){
      final initialContent = await rootBundle.loadString(initialStudySpaces);
      await studySpaceFile.create();
      await studySpaceFile.writeAsString(initialContent);
    }
    return studySpaceFile;
  }

  Future<String> readLocationFile() async {
  //Future<Map<String, dynamic>> readLocationFile() async {
    //String fileContent = "";

    log("running read location file");
    File file = await _locationFile;

    return await file.readAsString();
  }

  Future<String> readStudySpaceFile() async {
  //Future<Map<String, dynamic>> readStudySpaceFile() async {
    //String fileContent = "";
    File file = await _studySpaceFile;

    return await file.readAsString();
  }

  Future<List<Location>> writeLocationFile(List<Location> locations) async{
  //Future<Location> writeLocationFile(int id, String name, String hours, String address, String image, double coordNS, double coordEW, bool favorite) async {
    //final Location location = Location(id: id, name: name, hours: hours, address: address, image: image, coordNS: coordNS, coordEW: coordEW, isFavorite: favorite);

    File file = await _locationFile;
    await file.writeAsString(json.encode(locations));
    return locations;
  }

  Future<List<StudySpace>> writeStudySpaceFile(List<StudySpace> studyspaces) async{
  //Future<StudySpace> writeStudySpaceFile(int id, String name, int location, double crowdLevel, List<Amenities> currentAmenities, List<Amenities> generalAmenities, List<Map<String,String>> reviews) async {
    //final StudySpace space = StudySpace(id: id, name: name, location: location, crowdLevel: crowdLevel, currentAmenities: currentAmenities, generalAmenities: generalAmenities, reviews: reviews);

    File file = await _studySpaceFile;
    await file.writeAsString(json.encode(studyspaces));
    return studyspaces;
  }

}