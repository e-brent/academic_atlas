import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:academic_atlas/view_model/study_space_view_model.dart';
//import 'package:academic_atlas/model/study_space_model.dart';

class UpdateCrowdView extends StatelessWidget {
  const UpdateCrowdView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<StudySpaceViewModel>(context);

    return Scaffold (
      appBar: AppBar(
          title: Text("Update Crowd Information")
      ),
      body: Padding(
        padding:const EdgeInsets.all(16.0) ,
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            const Text(
              "How Crowded is it? "
            ),
            Slider(
              value:viewModel.crowdLevel,
              min:0,
              max:10,
              divisions: 10,
              onChanged: (value){
                //viewModel.crowdLevel(value);
              },
            ),
            const Text(
              "Choose Location Details:",
            ),
              Wrap(
                spacing: 8.0,
                runSpacing:8.0,
                children: List.generate(
                  viewModel.currentAmenities.length,
                    (index)=> FilterChip(
                      label: Text("option 1, option 2, option 3"),
                      //Text(viewModel.currentAmenities[index].amenity),
                      selected: true, //viewModel.currentAmenities[index].isSelected,
                      onSelected: null,
                    )
                ),
              ),
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