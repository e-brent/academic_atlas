import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:academic_atlas/view_model/location_detail_view_model.dart';
import 'dart:developer';

class StaticCrowdSlider extends StatefulWidget {
  final int studySpaceID;

  StaticCrowdSlider(this.studySpaceID);

  @override
  State<StaticCrowdSlider> createState() => _StaticCrowdSliderState();
}

class _StaticCrowdSliderState extends State<StaticCrowdSlider> {

  @override
  void initState() {
    super.initState();
    Provider.of<LocationDetailsViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LocationDetailsViewModel>(context);

    return Column(
      children: [
        Text("Current Crowd Level: ${vm.studyspaces.isNotEmpty ? vm.studyspaces[widget.studySpaceID].crowdLevel.toString() : "Loading..."}",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Slider(
          value: vm.studyspaces.isNotEmpty ? vm.studyspaces[widget.studySpaceID].crowdLevel : 0,
          min:0,
          max:10,
          divisions: 10,
          onChanged: (value){
            null;
          },
        )
      ]
    );
  }
}