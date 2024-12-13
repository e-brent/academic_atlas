import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:academic_atlas/view_model/location_detail_view_model.dart';
import 'package:academic_atlas/view_model/update_view_model.dart';
import 'package:intl/intl.dart';
import 'dart:developer';

import 'package:academic_atlas/router.dart' as LocalRouter;
import 'package:academic_atlas/constants.dart';

class UpdateCrowdView extends StatefulWidget {

  final int locationID;
  final int studySpaceID;
  const UpdateCrowdView(this.locationID, this.studySpaceID, {super.key});
  //const UpdateCrowdView(this.studySpaceID, {super.key});


  @override
  State<UpdateCrowdView> createState() => _UpdateCrowdViewState();
}

class _UpdateCrowdViewState extends State<UpdateCrowdView> {

  @override
  void initState() {
    super.initState();
    Provider.of<LocationDetailsViewModel>(context, listen: false).fetchStudySpaces(widget.locationID);
  }

  double _sliderValue = 5.0;
  //List<bool> _chipSelections = List.generate(8, (index) => false);

  final amenityItems = [
    "Quiet",
    "Loud",
    "Construction noise",
    "Small tables open",
    "Medium tables open",
    "Large tables open",
    "High top tables free",
    "No free tables",
    "Individual seats only",
    "Lots of tables available",
    "Outlets taken",
    "Outlets not working",
    "Outlets available",
    "No whiteboards free",
    "Whiteboards available",
    "Cold",
    "Hot",
    "Flickering lights",
    "Event going on",
    "Bad smells",
    "Free food/coffee",
    "Women's restroom is dirty",
    "Men's restroom is dirty",
    "Gender neutral restroom is dirty",
    "Dirty tables",
    "Service dog event",
    "Office hours group(s) working"
  ];
  List<String> selectedItems = [];

  String getFormattedDateTime() {
    final DateTime now = DateTime.now();
    final DateFormat dateFormat = DateFormat('MM-dd-yyyy  @  HH:mm', );
    return dateFormat.format(now);
  }

@override
  Widget build(BuildContext context) {
    //final viewModel = Provider.of<StudySpaceViewModel>(context);

    final vm = Provider.of<LocationDetailsViewModel>(context);
    //log(vm.toString());
    //log(widget.studySpaceID);

    String currCrowd = "Old crowd level: ${vm.studyspaces.isNotEmpty ? vm.getCrowdLevel(widget.studySpaceID).toString() : "loading..."}";
    //String currCrowd = "Old crowd level: ${vm.getCrowdLevel(widget.studySpaceID).toString()}";

    //String idlog = "SS ID: ${widget.studySpaceID.toString()}";

    var currAmenities = [];
    currAmenities.addAll(vm.studyspaces.isNotEmpty ? vm.studyspaces[widget.studySpaceID].currentAmenities.map((amenity) => amenity.amenity).toList() : [""]);

    String studySpaceName = vm.studyspaces.isNotEmpty ? vm.studyspaces[widget.studySpaceID].name : "Loading...";

    return Scaffold (
      appBar: AppBar(
          title: Text("Update Crowd for ${studySpaceName}",
            style: TextStyle( fontWeight: FontWeight.bold),
          ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:const EdgeInsets.all(16.0) ,
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              Center(
                child:
                Text(
                  " ${getFormattedDateTime()}",
                  style: TextStyle( fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "How Crowded is it? ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Slider(
                value:_sliderValue,//viewModel.crowdLevel,
                min:0,
                max:10,
                divisions: 10,
                onChanged: (value){
                  setState(() {
                    _sliderValue=value;
                  });
                },
              ),
              Text(
                "Updated Crowd Level: ${_sliderValue.toStringAsFixed(0)}",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                currCrowd,
                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.deepPurple.shade600),
              ),
              const SizedBox(height: 30),
              const Text("Share Some Location Details:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 5.0,
                runSpacing: 5.0,
                children: amenityItems.map((e) => Padding(
                  padding: const EdgeInsets.only(top:1),
                  child: FilterChip(
                      label: Text(e),
                      selected: selectedItems.contains(e),
                      onSelected: (bool value) {
                        if (selectedItems.contains(e)) {
                          selectedItems.remove(e);
                        } else {
                          selectedItems.add(e);
                        }
                        setState(() {});
                      }),
                ),
                ).toList(),
              ),
              const SizedBox(height: 50),
              Center(
                child: ElevatedButton(
                  onPressed: () {

                    for(String item in selectedItems){
                      if (currAmenities.contains(item)){
                        selectedItems.remove(item);
                      }
                    }

                    vm.setCrowdLevel(widget.studySpaceID, _sliderValue);
                    vm.setCurrentAmenities(widget.studySpaceID, selectedItems);
                    //log(_sliderValue.toString());

                    //Navigator.pushNamed(context, detailsRoute, arguments: widget.locationID);
                    //Navigator.pop(context, detailsRoute);
                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Crowd update submitted!")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo.shade100,
                    minimumSize: Size(300, 50),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}