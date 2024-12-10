import 'package:flutter/material.dart';
import 'package:academic_atlas/view/update_crowd_view.dart';
import 'package:provider/provider.dart';
import 'package:academic_atlas/view_model/location_detail_view_model.dart';
import 'package:academic_atlas/widgets/current_amenities_list.dart';
import 'package:academic_atlas/widgets/static_amenities_list.dart';
import 'package:academic_atlas/widgets/reviews.dart';
import 'dart:developer';

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

    log(widget.locationID.toString());
    log(items.toString());

    var studySpaceID = 0;

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

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(vm.location!.image,
              height: 250,
              width: 350,
              fit: BoxFit.cover,),
            SizedBox(height:30),
            Text("Select a study space in building: ${vm.location != null ? vm.location!.name : 'loading...'}",style: TextStyle(fontStyle: FontStyle.italic),),
            SizedBox(height: 30),
            DropdownButton<String>(
                isDense: false,
                hint: Text("Select study space"),
                value: dropdownvalue,
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items,style: TextStyle(fontSize: 18), ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                  studySpaceID = items.indexOf(dropdownvalue) - 1;
                },
              ),
            SizedBox(height:40),
            SizedBox(height:20),
            Column (
                children: [
                  Text('Location/study space details:',style: TextStyle(decoration:TextDecoration.underline, fontSize: 24, fontWeight: FontWeight.bold),),
                  SizedBox(height:30),
                  Text("Current Crowd Level: 7",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
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
                  SizedBox(height:20),
                  const Divider(
                    height: 20,
                    thickness: 2,
                    indent: 30,
                    endIndent: 30,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  Text("Current Amenities:",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 215,
                    width: 500,
                    child: CurrAmenitiesList(studySpaceID),
                  ),
                  const Divider(
                    height: 20,
                    thickness: 2,
                    indent: 30,
                    endIndent: 30,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 30),
                  Row(
                      children: <Widget>[
                        // this isn't showing up for some reason idk
                        Expanded(child:
                          Center(child:
                              Column(
                                children: [
                                  Text("Address:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
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
                                  Text("Hours:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                  Text(vm.location != null ? vm.location!.hours : 'loading...')
                              ]
                            )
                          )
                        )
                      ]
                  ),
                  SizedBox(height: 40),
                  const Divider(
                    height: 20,
                    thickness: 2,
                    indent: 30,
                    endIndent: 30,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 10),
                  Text("Building Amenities:",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  SizedBox(height: 10),
                  Container(
                    height: 215,
                    width: 500,
                    child: StaticAmenitiesList(studySpaceID),
                  ),
                  const Divider(
                    height: 20,
                    thickness: 2,
                    indent: 30,
                    endIndent: 30,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  Text("Reviews:",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  Container(
                    height: 400,
                    width: 500,
                    child: Reviews(studySpaceID),
                  ),
                  SizedBox(height: 30),
                  Text("Leave a Review:",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Container(
                        width: 375,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter your name',
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 375,
                        child: TextField(
                          maxLines: null,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Write your review here',
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          // make review go to the widget somehow ugh
                        },
                        child: Text('Submit'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(300, 50),
                        ),
                      ),
                      SizedBox(height: 50),
                    ],
                  )
                ]
            )
          ],
        ),
      ),
    );
  }

}

