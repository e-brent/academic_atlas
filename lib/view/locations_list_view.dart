import 'package:flutter/material.dart';
import 'package:academic_atlas/view_model/location_list_view_model.dart';
import 'package:academic_atlas/widgets/locations_list.dart';

import 'package:provider/provider.dart';

class LocationListView extends StatefulWidget {
  @override
  _LocationListViewState createState() => _LocationListViewState();
}

class _LocationListViewState extends State<LocationListView> {

  @override
  void initState() {
    super.initState();
    Provider.of<LocationListViewModel>(context, listen: false).fetchLocations();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LocationListViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Locations List")
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: (Column( children: <Widget> [
          Expanded(
            child: LocationList(locations: vm.locations)
          )
        ])
        )
      )
    );
  }
}
