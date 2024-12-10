import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:academic_atlas/view_model/location_detail_view_model.dart';
//import 'package:academic_atlas/view_model/study_space_view_model.dart';
//import 'package:academic_atlas/model/study_space_model.dart';
import 'package:intl/intl.dart';
import 'dart:developer';

import 'package:academic_atlas/router.dart' as LocalRouter;
import 'package:academic_atlas/constants.dart';

class UpdateCrowdView extends StatefulWidget {

  final int locationID;
  final int studySpaceID;
  const UpdateCrowdView(this.locationID, this.studySpaceID, {super.key});

  @override
  State<UpdateCrowdView> createState() => _UpdateCrowdViewState();
}

class _UpdateCrowdViewState extends State<UpdateCrowdView> {

  @override
  void initState() {
    super.initState();
    Provider.of<LocationDetailsViewModel>(context, listen: false);
  }

  double _sliderValue = 5.0;
  List<bool> _chipSelections = List.generate(8, (index) => false);

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

    String currCrowd = "Current crowd: ${vm.getCrowdLevel(widget.studySpaceID).toString()}";
    //String idlog = "SS ID: ${widget.studySpaceID.toString()}";

    //log(idlog);

    return Scaffold (
      appBar: AppBar(
          title: Text("Update Crowd Information",
            style: TextStyle( fontWeight: FontWeight.bold),
          ),

      ),
      body: Padding(
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
            const SizedBox(height: 50),
            Text(currCrowd),
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
                //viewModel.crowdLevel(value);

              },
            ),
            Text("Crowd Level: ${_sliderValue.toStringAsFixed(0)}",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 50),
            const Text("Share Some Location Details:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
              Wrap(
                spacing: 8.0,
                runSpacing:8.0,
                children: List.generate(8, (index) {
                  //viewModel.currentAmenities.length,
                  return FilterChip(
                    label: Text("Option ${index + 1}"),
                    //Text(viewModel.currentAmenities[index].amenity),
                    selected: _chipSelections[index],
                    //viewModel.currentAmenities[index].isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _chipSelections[index] = selected;
                      });
                    },
                  );
                }),
              ),
            const SizedBox(height: 50),
              Center(
                child: ElevatedButton(
                  onPressed: () {

                    //log(_sliderValue.toString());
                    vm.setCrowdLevel(widget.studySpaceID, _sliderValue);

                    //Navigator.pushNamed(context, detailsRoute, arguments: vm.location!.id);
                    Navigator.pop(context, detailsRoute);

                  ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Info Submitted!")),
                  );
                  },
                  child: const Text("Submit"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}