import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:academic_atlas/view_model/location_detail_view_model.dart';

class LocationDetailsView extends StatefulWidget {
  final int locationID;

  LocationDetailsView(this.locationID);

  @override
  State<LocationDetailsView> createState() => _LocationDetailsViewState();
}

class _LocationDetailsViewState extends State<LocationDetailsView> {

  @override
  void initState() {
    super.initState();
    Provider.of<LocationDetailsViewModel>(context, listen: false).fetchLocation(widget.locationID);
    Provider.of<LocationDetailsViewModel>(context, listen: false).fetchStudySpaces(widget.locationID);
  }

  String _dropdownvalue ="";

  @override
  Widget build(BuildContext context) {

    final vm = Provider.of<LocationDetailsViewModel>(context);

    // Initial Selected Value
    //_dropdownvalue = vm.studyspaces.first.name;

    var items = vm.getStudySpaceNames(widget.locationID);

    return Scaffold (
      appBar: AppBar(
          title: Text(vm.location != null ? vm.location!.name : 'Loading...')
      ),
      body: Column(
        children: [
          new Center(
            child: new DropdownButton<String>(
              isDense: true,
              hint: new Text("Select study space"),
              value: _dropdownvalue,
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _dropdownvalue = newValue!;
                });
              },
            ),
          ),
          Text(_dropdownvalue)
        ]
      )
    );
  }

}

