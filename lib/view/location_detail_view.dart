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

  @override
  Widget build(BuildContext context) {

    final vm = Provider.of<LocationDetailsViewModel>(context);

    return Scaffold (
      appBar: AppBar(
          title: Text(vm.location != null ? vm.location!.name : 'Loading...')
      ),
      body: Text("This is a location details page for ${vm.location != null ? vm.location!.name : 'loading...'}"),
    );
  }

}

