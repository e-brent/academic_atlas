import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';



class LocationDetailsView extends StatefulWidget {

  const LocationDetailsView({super.key});

  @override
  State<LocationDetailsView> createState() => _LocationDetailsViewState();
}

class _LocationDetailsViewState extends State<LocationDetailsView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
          title: Text("Location Details Page")
      ),
      body: Text("This is a location details page"),
    );
  }

}

