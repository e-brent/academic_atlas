import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'router.dart' as LocalRouter;
import 'constants.dart';

import 'package:academic_atlas/view_model/location_detail_view_model.dart';
import 'package:academic_atlas/view_model/location_list_view_model.dart';
import 'package:academic_atlas/view_model/update_view_model.dart';
import 'package:academic_atlas/view_model/location_view_model.dart';
import 'package:academic_atlas/view_model/study_space_view_model.dart';

import 'package:academic_atlas/view/locations_list_view.dart';
import 'package:academic_atlas/view/map_view.dart';
import 'package:academic_atlas/view/update_crowd_view.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => LocationListViewModel()),
          ChangeNotifierProvider(create: (context) => LocationDetailsViewModel()),
          ChangeNotifierProvider(create: (context) => UpdateViewModel())
          //ChangeNotifierProvider(create: (context) => StudySpaceViewModel(studyspace: StudySpace as StudySpace)),
        ],
      child: MaterialApp(
      title: 'Pitt Academic Atlas',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.light),
        textTheme: TextTheme(
          titleLarge: GoogleFonts.oswald(
            fontSize: 30,
            //fontWeight: FontWeight.bold,
          ),
          titleMedium: GoogleFonts.oswald(
            fontSize: 20
          )
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            // Set the predictive back transitions for Android.
            TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
          },
        )
      ),
            home:Column(
            children: [
              Container(
                width:double.infinity,
                height: 425,
                child:MapView(),
              ),
              Expanded(
                child: LocationListView(),
                )
            ],

          ),
        onGenerateRoute: LocalRouter.Router.generateRoute,
        initialRoute: listRoute,
      ),

    );
  }
}

