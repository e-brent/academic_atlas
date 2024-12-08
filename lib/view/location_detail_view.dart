import 'package:flutter/material.dart';
import 'package:academic_atlas/view/update_crowd_view.dart';
import 'package:provider/provider.dart';
import 'package:academic_atlas/view_model/location_detail_view_model.dart';
import 'package:academic_atlas/widgets/current_amenities_list.dart';

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
          title: Text("${vm.location!.name} Details")
      ),

      bottomNavigationBar: Container (
          height: 63,
          child: ElevatedButton(
            onPressed:(){
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => const UpdateCrowdView()), );
            },
            child:Text("Update Crowd Level"),
          )
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(vm.location!.image,
              height: 250,
              width: 350,
              fit: BoxFit.cover,),
            SizedBox(height:30),
            Text("Select a study space in building: ${vm.location != null ? vm.location!.name : 'loading...'}"),
            SizedBox(height: 30),
            DropdownButton<String>(
                isDense: true,
                hint: Text("Select study space"),
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
            SizedBox(height:40),
            Column (
                children: [
                  Text('Location/study space details...'),
                  Slider(
                    value: 7,//viewModel.crowdLevel,
                    //value: vm.studyspace.crowedLevel != null ? vm.studyspace!.crowdLevel : 0,//viewModel.crowdLevel,
                    min:0,
                    max:10,
                    divisions: 10,
                    onChanged: (value){
                      null;
                      //viewModel.crowdLevel(value);
                    },
                  ),
                  Text("Crowd Level: 7",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  Text("Current Amenities:"),
                  SizedBox(height: 10),
                  CurrAmenitiesList(spaceDetails: vm.studyspaces),
                  SizedBox(height: 30),
                  Row(
                      children: <Widget>[
                        // this isn't showing up for some reason idk
                        Expanded(child:
                          Center(child:
                              Column(
                                children: [
                                  Text("Address:"),
                                  Text(vm.location != null ? vm.location!.address : 'loading...')
                                ]
                              )
                          )
                        ),
                        VerticalDivider(), //idk why this isn't showing up
                        Expanded(child:
                          Center(child:
                            Column(
                              children: [
                                Center(child: Text("Hours: "))
                              ]
                            )
                          )
                        )
                      ]
                  )
                ]
            )
          ],
        ),
      ),
    );
  }

}

