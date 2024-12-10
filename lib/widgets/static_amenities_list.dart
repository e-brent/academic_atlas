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
    staticAmenities.addAll(vm.studyspaces[widget.studySpaceID].generalAmenities.map((amenity) => amenity.amenity).toList());

    //log(currAmenities.toString());

    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 3,
        childAspectRatio: (5/3),
      children: staticAmenities.map((e) =>
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.deepPurple.shade100,
            child: Text(e),
          )
      ).toList(),
    );
  }
}