import 'package:academic_atlas/model/study_space_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:academic_atlas/view_model/location_detail_view_model.dart';
import 'package:academic_atlas/view_model/study_space_view_model.dart';
import 'dart:developer';


import 'package:academic_atlas/router.dart' as LocalRouter;
import 'package:academic_atlas/constants.dart';

class StaticAmenitiesList extends StatefulWidget {
  final int studySpaceID;

  StaticAmenitiesList(this.studySpaceID);

  @override
  State<StaticAmenitiesList> createState() => _StaticAmenitiesListState();
}

class _StaticAmenitiesListState extends State<StaticAmenitiesList> {

  @override
  void initState() {
    super.initState();
    Provider.of<LocationDetailsViewModel>(context, listen: false).fetchStudySpace(widget.studySpaceID);
    //Provider.of<StudySpaceViewModel>(context, listen: false).currentAmenities;
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LocationDetailsViewModel>(context);

    var staticAmenities = [];
    staticAmenities.addAll(vm.studySpace!.currentAmenities);

    //log(currAmenities.toString());

    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 3,
        childAspectRatio: (5/3),
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.deepPurple.shade100,
            child: const Text('no outlets',textAlign: TextAlign.center,),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.deepPurple.shade100,
            child: const Text('small tables only',textAlign: TextAlign.center,),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color:Colors.deepPurple.shade100,
            child: const Text('loud',textAlign: TextAlign.center,),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.deepPurple.shade100,
            child: const Text('too much construction noise',textAlign: TextAlign.center,),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.deepPurple.shade100,
            child: const Text('some medium tables',textAlign: TextAlign.center,),
          ),
        ],
    );
  }
}