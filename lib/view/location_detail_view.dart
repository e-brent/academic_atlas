import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'package:academic_atlas/view/update_crowd_view.dart';


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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("This is a location details page"),
            ElevatedButton(
              onPressed:(){
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const UpdateCrowdView()), );
            },
              child:Text("Update Crowd Level"),
            )
          ],
        ),
      )


    );
  }

}

