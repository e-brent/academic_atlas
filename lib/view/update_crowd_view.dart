import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'package:academic_atlas/view_model/study_space_view_model.dart';
//import 'package:academic_atlas/model/study_space_model.dart';
import 'package:intl/intl.dart';

class UpdateCrowdView extends StatefulWidget {
  const UpdateCrowdView({super.key});

  @override
  _UpdateCrowdViewState createState() => _UpdateCrowdViewState();
}

class _UpdateCrowdViewState extends State<UpdateCrowdView> {
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