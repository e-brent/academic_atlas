//import 'package:academic_atlas/model/study_space_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:academic_atlas/view_model/location_detail_view_model.dart';
//import 'package:academic_atlas/view_model/study_space_view_model.dart';
//import 'dart:developer';


//import 'package:academic_atlas/router.dart' as LocalRouter;
//import 'package:academic_atlas/constants.dart';

class Reviews extends StatefulWidget {
  final int studySpaceID;
  //final void Function(String name, String content) onAddReview;
  //Reviews(this.studySpaceID,{required this.onAddReview});
  Reviews(this.studySpaceID);

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  //List<Map<String, String>> reviews = [];

  @override
  void initState() {
    super.initState();
    // Fetch initial reviews
    Provider.of<LocationDetailsViewModel>(context, listen: false).fetchStudySpace(widget.studySpaceID);

  }

  /*void addReview(String name, String content) {
    setState(() {
      reviews.add({'name': name, 'content': content});
    });
  }*/

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LocationDetailsViewModel>(context, listen: false);
    //vm.fetchStudySpace(widget.studySpaceID);
    //reviews = vm.studySpace?.reviews ?? [];
    //reviews = vm.studyspaces.isNotEmpty ? vm.studyspaces[widget.studySpaceID].reviews : [];

    var reviews = [];
    reviews.addAll(vm.studyspaces.isNotEmpty ? vm.studyspaces[widget.studySpaceID].reviews : []);

    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 9 / 3,
      ),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.indigo.shade100,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Text(
            '${review['name']}\n\n${review['content']}',
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
