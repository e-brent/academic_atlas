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
  final TextEditingController nameController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();
  List<Map<String, String>> reviews = [];

  @override
  void initState() {
    super.initState();
    Provider.of<LocationDetailsViewModel>(context, listen: false).fetchLocation(widget.locationID);
    Provider.of<LocationDetailsViewModel>(context, listen: false).fetchStudySpaces(widget.locationID);
  }

  String dropdownvalue = "";
  var studySpaceID = 0;
  var localStudySpace = 0;

  @override
  Widget build(BuildContext context) {

    final vm = Provider.of<LocationDetailsViewModel>(context);

    // Initial Selected Value
    var items = [""];
    items.addAll(vm.getStudySpaceNames(widget.locationID));
    log("items length: ${items.length.toString()}");

    var ids = [1000];
    ids.addAll(vm.getStudySpaceIds(widget.locationID));
    log("ids length: ${ids.length.toString()}");

    log("study spaces: ${vm.studyspaces.toString()}");

    Map<int, String> idNamePairs = {};
    Map<int, String> nameOrder = {};

    for (int i = 1; i < ids.length; i++){
      idNamePairs[ids[i]] = items[i];
      nameOrder[i- 1] = items[i];
    }

    //log(widget.locationID.toString());
    log(idNamePairs.toString());

    return Scaffold (
      appBar: AppBar(
          title: Text("${vm.location!.name} Details")
      ),

      bottomNavigationBar: Container (
          height: 63,
          child: ElevatedButton(
            onPressed:(){
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => UpdateCrowdView(vm.location!.id, studySpaceID)));
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
            Text("Select a study space in building: ${vm.location}",style: TextStyle(fontStyle: FontStyle.italic),),
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
                  //studySpaceID = items.indexOf(dropdownvalue) - 1;
                  //studySpaceID = idNamePairs.entries.firstWhere((k) => k.value == dropdownvalue).key;
                  localStudySpace = nameOrder.entries.firstWhere((k) => k.value == dropdownvalue).key;
                  studySpaceID = nameOrder.entries.firstWhere((k) => k.value == dropdownvalue).key;

                  log("here ${studySpaceID.toString()}");
                },
              ),
            SizedBox(height:40),
            SizedBox(height:20),
            Column (
                children: [
                  Text('Location/study space details:',style: TextStyle(decoration:TextDecoration.underline, fontSize: 24, fontWeight: FontWeight.bold),),
                  SizedBox(height:30),
                  Text("Current Crowd Level: ${vm.studyspaces[localStudySpace].crowdLevel.toString()}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Slider(
                    value: vm.studyspaces[localStudySpace].crowdLevel,
                    //value: 7,//viewModel.crowdLevel,
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
                                  Text(vm.location!.address)
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
                                  Text(vm.location!.hours)
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
                    child: Reviews(localStudySpace,onAddReview: (name, content) {
                      setState(() {
                        reviews.add({'name': name, 'content': content});
                      });
                    }),
                  ),
                  SizedBox(height: 30),
                  Text("Leave a Review:",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Container(
                        width: 375,
                        child: TextField(
                          controller: nameController,
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
                          controller: reviewController,
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
                        String name = nameController.text.trim();
                        String reviewContent = reviewController.text.trim();

                        if (name.isNotEmpty && reviewContent.isNotEmpty) {
                          setState(() {
                            reviews.add(
                                {'name': name, 'content': reviewContent});
                          });
                          nameController.clear();
                          reviewController.clear();
                        }
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

