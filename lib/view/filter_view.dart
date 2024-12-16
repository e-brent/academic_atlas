import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:academic_atlas/view_model/location_detail_view_model.dart';

class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  _FilterViewState createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  @override
  void initState() {
    super.initState();
    Provider.of<LocationDetailsViewModel>(context, listen: false).fetchAllStudySpaces();
  }

  String? _selectedCrowdLevel;
  final Map<String, bool> _amenities = {
    "Quiet": false,
    "Loud": false,
    "Construction noise": false,
    "Small tables open": false,
    "Medium tables open": false,
    "Large tables open": false,
    "High top tables free": false,
    "No free tables": false,
    "Individual seats only": false,
    "Lots of tables available": false,
    "Outlets taken": false,
    "Outlets not working": false,
    "Outlets available": false,
    "No whiteboards free": false,
    "Whiteboards available": false,
    "Cold": false,
    "Hot": false,
    "Flickering lights": false,
    "Event going on": false,
    "Bad smells": false,
    "Free food/coffee": false,
    "Women's restroom is dirty": false,
    "Men's restroom is dirty": false,
    "Gender neutral restroom is dirty": false,
    "Dirty tables": false,
    "Service dog event": false,
    "Office hours group(s) working": false,
  };
  bool _showFavs = false;

  void _clearFilters() {
    setState(() {
      _selectedCrowdLevel = null;
      _showFavs = false;
      _amenities.updateAll((key, value) => false);

    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LocationDetailsViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Filter Locations",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            CheckboxListTile(
              title: const Text(
                "Show Favorites Only",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              value: _showFavs,
              onChanged: (value) {
                setState(() {
                  _showFavs = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "Crowd Level (1 = Empty to 10 = Very Crowded)",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              hint: const Text("Select the Crowd Level"),
              value: _selectedCrowdLevel,
              items: List.generate(
                10,
                    (index) => DropdownMenuItem(
                  value: (index + 1).toString(),
                  child: Text("Level ${index + 1}"),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _selectedCrowdLevel = value;
                });
              },
              isExpanded: true,
              underline: Container(
                height: 1,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Amenities:",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: _amenities.keys.map((amenity) {
                  return CheckboxListTile(
                    title: Text(amenity),
                    value: _amenities[amenity],
                    onChanged: (value) {
                      setState(() {
                        _amenities[amenity] = value!;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final selectedAmenities = _amenities.entries.where((entry) => entry.value).map((entry) => entry.key).toList();

                    viewModel.filterStudySpaces(crowdLevel: _selectedCrowdLevel, selectedAmenities: selectedAmenities, showFavs: _showFavs,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple.shade100,
                    minimumSize: const Size(140, 50),
                  ),
                  child: const Text(
                    'Apply Filters',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  onPressed: _clearFilters,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple.shade100,
                    minimumSize: const Size(140, 50),
                  ),
                  child: const Text(
                    'Clear',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Study Spaces:",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: viewModel.filteredStudySpaces.length,
                itemBuilder: (context, index) {
                  final space = viewModel.filteredStudySpaces[index];
                  return Card(
                    child: ListTile(
                      title: Text(space.name),
                      subtitle: Text('Crowd Level: ${space.crowdLevel.toStringAsFixed(1)}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
