import 'package:academic_atlas/view/update_crowd_view.dart';
import 'package:academic_atlas/view_model/location_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:academic_atlas/constants.dart';

import 'package:academic_atlas/view_model/location_list_view_model.dart';
//import 'package:academic_atlas/view_model/location_detail_view_model.dart';

import 'package:academic_atlas/view/locations_list_view.dart';
import 'package:academic_atlas/view/location_detail_view.dart';

class Router{
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case listRoute:
        return MaterialPageRoute(builder: (_) =>
          ChangeNotifierProvider(
              create: (context) => LocationListViewModel(),
              child: LocationListView(),
          )
        );
      case detailsRoute:
        var locationID = settings.arguments as int;
        return MaterialPageRoute(builder: (_) =>
          ChangeNotifierProvider(
            create: (context) => LocationListViewModel(),
            child: LocationDetailsView(locationID),
          )
        );
      case updateRoute:
        var locationID = settings.arguments as int;
        var studySpaceID = settings.arguments as int;
        return MaterialPageRoute(builder: (_) =>
          ChangeNotifierProvider(
            create: (context) => LocationDetailsViewModel(),
            child: UpdateCrowdView(locationID, studySpaceID),
          )
        );
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text("no route defined for ${settings.name}")
              ),
            ));
    }
  }
}