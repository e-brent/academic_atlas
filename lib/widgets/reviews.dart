import 'package:academic_atlas/model/study_space_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:academic_atlas/view_model/location_detail_view_model.dart';
import 'package:academic_atlas/view_model/study_space_view_model.dart';
import 'dart:developer';


import 'package:academic_atlas/router.dart' as LocalRouter;
import 'package:academic_atlas/constants.dart';

class Reviews extends StatefulWidget {
  final int studySpaceID;

  Reviews(this.studySpaceID);

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {

  @override
  void initState() {
    super.initState();
    Provider.of<LocationDetailsViewModel>(context, listen: false).fetchStudySpace(widget.studySpaceID);
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LocationDetailsViewModel>(context);

    var reviews = [];
    reviews.addAll(vm.studySpace!.reviews);


    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 1,
      childAspectRatio: (9/3),
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.deepPurple.shade100,
          child:Text('Amy S\n\nI enjoyed all of the natural lighting, but the seating situation left something to be desired.',textAlign: TextAlign.center,),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.deepPurple.shade100,
          child: const Text('Kruti K \n\n I come here to study with my friends all the time! It is a great place to hang out and also get lots of work done.',textAlign: TextAlign.center,),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color:Colors.deepPurple.shade100,
          child: const Text('Grace S\n\n I wish I had never been inside this building. There is never a seat, and it is so loud I can barely hear myself think! Would not recommend.',textAlign: TextAlign.center,),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.deepPurple.shade100,
          child: const Text('Emme B\n\n Loved the new seating options! really wish people would not leave trash on the ground though, it is distracting for the studiers.',textAlign: TextAlign.center,),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          color: Colors.deepPurple.shade100,
          child: const Text('Sophie M\n\n Great for group work! There are usually a lot of open tables with outlets, and I do not feel bad when we have to collaborate out loud.',textAlign: TextAlign.center,),
        ),
      ],
    );
  }
}