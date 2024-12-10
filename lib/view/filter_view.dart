import 'package:flutter/material.dart';

class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  _FilterViewState createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  String? _selectedCrowdLevel;
  final Map<String, bool> _amenities = {
    "No Seating": false,
    "Outlets": false,
    "WiFi": false,
    "Quiet Space": false,
    "Natural Lighting": false,
    "Food Nearby": false,
    "Wheelchair Accessible": false,
    "Large Tables": false,
    "Small Tables": false,
    "Pet Friendly": false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Filter Locations",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Text(
              "Crowd Level (1 = Empty to 10 = Very Crowded)",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              hint: Text("Select the Crowd Level"),
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
            const SizedBox(height: 50),
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
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final selectedAmenities = _amenities.entries
                      .where((entry) => entry.value)
                      .map((entry) => entry.key)
                      .toList();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Selected Crowd Level: $_selectedCrowdLevel\n"
                            "Selected Amenities: ${selectedAmenities.join(', ')}",
                      ),
                    ),
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
