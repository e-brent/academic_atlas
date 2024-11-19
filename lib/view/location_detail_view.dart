import 'package:flutter/material.dart';
import 'package:academic_atlas/view/update_crowd_view.dart';

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

  String dropdownvalue = "";

  @override
  Widget build(BuildContext context) {

    final vm = Provider.of<LocationDetailsViewModel>(context);

    // Initial Selected Value
    var items = [""];
    items.addAll(vm.getStudySpaceNames(widget.locationID));

    return Scaffold (
      appBar: AppBar(
          title: Text(vm.location != null ? vm.location!.name : 'Loading...')
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("This is a location details pagefor ${vm.location != null ? vm.location!.name : 'loading...'}"),
            ElevatedButton(
              onPressed:(){
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const UpdateCrowdView()), );
            },
              child:Text("Update Crowd Level"),
            ),
            new Center(
            child: new DropdownButton<String>(
              isDense: true,
              hint: new Text("Select study space"),
              value: dropdownvalue,
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            ),
          )
          ],
        ),
      )
    );
  }

}

