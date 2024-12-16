import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:developer';

import 'package:academic_atlas/view/update_crowd_view.dart';

import 'package:academic_atlas/view_model/location_detail_view_model.dart';

import 'package:academic_atlas/widgets/current_amenities_list.dart';
import 'package:academic_atlas/widgets/static_amenities_list.dart';
import 'package:academic_atlas/widgets/reviews.dart';
import 'package:academic_atlas/widgets/static_crowd_slider.dart';

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
  String dropdownvalue = "";
  List<String> items = [];
  List<int> ids = [];
  var studySpaceID = 0;
  var localStudySpace = 0;
  Map<int, String> nameOrder = {};

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    await Provider.of<LocationDetailsViewModel>(context, listen: false).fetchLocation(widget.locationID);
    await Provider.of<LocationDetailsViewModel>(context, listen: false).fetchStudySpaces(widget.locationID);

    if(Provider.of<LocationDetailsViewModel>(context, listen: false).getStudySpaceNames(widget.locationID).isNotEmpty){
      setState(() {
        log("setting values");
        dropdownvalue = Provider.of<LocationDetailsViewModel>(context, listen: false).getStudySpaceNames(widget.locationID).first;
        items.addAll(Provider.of<LocationDetailsViewModel>(context, listen: false).getStudySpaceNames(widget.locationID));
        ids.addAll(Provider.of<LocationDetailsViewModel>(context, listen: false).getStudySpaceIds(widget.locationID));

        for (int i = 0; i < ids.length; i++){
          //idNamePairs[ids[i]] = items[i];
          nameOrder[i] = items[i];
        }
      });

    }
  }

  @override
  Widget build(BuildContext context) {

    final vm = Provider.of<LocationDetailsViewModel>(context, listen: false);

    return Scaffold (
      extendBody: true,
      appBar: AppBar(
        elevation: 10,
        shadowColor: Colors.black,
        title: Text(vm.location != null ? vm.location!.name : "Loading...")
      ),

      bottomNavigationBar: Container (
          height: 70,
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          color: const Color(0x00ffffff),
          child: ElevatedButton(
            onPressed:(){
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => UpdateCrowdView(vm.location!.id, localStudySpace)));
                //MaterialPageRoute(builder: (context) => UpdateCrowdView(localStudySpace)));
                log(localStudySpace.toString());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple.shade900.withBlue(80),
              elevation: 10.0,
              shadowColor: Colors.black,
            ),
            child: Text(
              'Update Crowd Level',
              style: TextStyle(color: Colors.white),
            ),
          )
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height:10),
            Image.asset(vm.location?.image ?? "assets/default.png",
              height: 250,
              width: 350,
              fit: BoxFit.cover,
            ),
            SizedBox(height:30),
            Text("Select a study space in ${vm.location != null ? vm.location!.name : "Loading..."}",style: TextStyle(fontStyle: FontStyle.italic),),
            SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.deepPurple.shade100,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.deepPurple)
            ),
            // dropdown below..
            child:
              DropdownButton<String>(
                  isDense: false,
                  hint: Text("Select a study space"),
                  value: dropdownvalue,
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(
                        items,
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      dropdownvalue = value!;
                    });
                    //studySpaceID = items.indexOf(dropdownvalue) - 1;
                    //studySpaceID = idNamePairs.entries.firstWhere((k) => k.value == dropdownvalue).key;
                    localStudySpace = nameOrder.entries.firstWhere((k) => k.value == dropdownvalue).key;
                    //studySpaceID = nameOrder.entries.firstWhere((k) => k.value == dropdownvalue).key;

                    //log("here ${dropdownvalue}");
                  },
                ),
            ),
            //SizedBox(height:40),
            SizedBox(height:40),
            Column (
                children: [
                  StaticCrowdSlider(localStudySpace),
                  const Divider(
                    height: 20,
                    thickness: 2,
                    indent: 30,
                    endIndent: 30,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  Text("Current status:",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 170,
                    width: 500,
                    child: CurrAmenitiesList(localStudySpace),
                  ),
                  const Divider(
                    height: 20,
                    thickness: 2,
                    indent: 30,
                    endIndent: 30,
                    color: Colors.grey,
                  ),
                  //SizedBox(height: 10),
                  Padding(
                      padding: const EdgeInsets.all(16.0),
                  child: Container(
                    //color: Colors.indigo.shade100,
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade100,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    child: Row(
                        children: <Widget>[
                          // this isn't showing up for some reason idk
                          Expanded(child:
                            Center(child:
                                Column(
                                  children: [
                                    Text("Address:\n", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                    Text(vm.location != null ? vm.location!.address : "Address loading...")
                                  ]
                                )
                            )
                          ),
                          VerticalDivider(), //idk why this isn't showing up
                          Expanded(child:
                            Center(child:
                              Column(
                                  children: [
                                    Text("\nHours:\n", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                    Text(vm.location != null ? vm.location!.hours : "Hours loading..."),
                                    Text("\n")
                                ]
                              )
                            )
                          )
                        ]
                    )
                  )
                  ),
                  //SizedBox(height: 20),
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
                    height: 200,
                    width: 500,
                    child: StaticAmenitiesList(localStudySpace),
                  ),
                  const Divider(
                    height: 20,
                    thickness: 2,
                    indent: 30,
                    endIndent: 30,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 10),
                  Text("Reviews:",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  Container(
                    height: 400,
                    width: 500,
                    /*child: Reviews(localStudySpace,onAddReview: (name, content) {
                      setState(() {
                        reviews.add({'name': name, 'content': content});
                      });
                    }),*/
                    child: Reviews(localStudySpace),
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

                          vm.addReview(localStudySpace, {'name': name, 'content': reviewContent});
                          nameController.clear();
                          reviewController.clear();
                        }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo.shade100,
                          minimumSize: Size(300, 50),
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 75),
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

