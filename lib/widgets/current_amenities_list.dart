import 'package:flutter/material.dart';
import 'package:academic_atlas/view_model/location_detail_view_model.dart';
import 'package:academic_atlas/view_model/study_space_view_model.dart';

import 'package:academic_atlas/router.dart' as LocalRouter;
import 'package:academic_atlas/constants.dart';

class CurrAmenitiesList extends StatelessWidget {
  final List<StudySpaceViewModel> spaceDetails;

  CurrAmenitiesList({required this.spaceDetails});

  @override
  Widget build (BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing:8.0,
      children: List.generate(8, (index) {
        //viewModel.currentAmenities.length,
        return FilterChip(
          label: Text("Option ${index + 1}"),
          //Text(viewModel.currentAmenities[index].amenity),
          //selected: _chipSelections[index],
          //viewModel.currentAmenities[index].isSelected,
          onSelected: (selected) {
            null;
          },
        );
      }),
    );
  }
}
