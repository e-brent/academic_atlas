import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'package:academic_atlas/view_model/study_space_view_model.dart';
//import 'package:academic_atlas/model/study_space_model.dart';
import 'package:intl/intl.dart';

class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  _FilterViewState createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  List<bool> _chipSelections = List.generate(8, (index) => false);

  @override
  Widget build(BuildContext context) {
    //final viewModel = Provider.of<StudySpaceViewModel>(context);

    return Scaffold (
      appBar: AppBar(
        title: Text("Filter Locations",
          style: TextStyle( fontWeight: FontWeight.bold),
        ),

      ),
      body: Padding(
        padding:const EdgeInsets.all(16.0) ,
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Text("Crowd Level:",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 50),
            const Text("Amenities:",
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