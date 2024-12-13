import 'package:academic_atlas/model/location_model.dart';
import 'package:flutter/material.dart';
import 'package:academic_atlas/view_model/location_list_view_model.dart';
import 'package:provider/provider.dart';
import 'dart:developer';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<String> locations = [];
  List<String> searchResults = [];

  @override
  void initState() {
    super.initState();
    //Provider.of<LocationListViewModel>(context, listen: false).fetchLocations();
    //locations.addAll(Provider.of<LocationListViewModel>(context, listen: false).getLocationNames());
    _loadLocations();
  }

  void _loadLocations()
  {
    final vm = Provider.of<LocationListViewModel>(context, listen: false);
    vm.fetchLocations().then((_)
    {
      setState(() {
        locations=vm.getLocationNames();
        searchResults = List.from(locations);
      });
    });
  }

  void onQueryChanged(String query) {
    setState(() {
      searchResults = locations
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LocationListViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Campus Buildings'),
      ),
      body: Column(
        children: [
          SearchBar(onQueryChanged: onQueryChanged),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final locationName = searchResults[index];
                final location = vm.locations.firstWhere(
                      (location) => location.name == locationName
                );
                return GestureDetector(
                  onTap:(){
                      log(location.id.toString());
                      Navigator.pushNamed(context, '/details', arguments: location.id,);
                    },
                    child: Card(
                      child: ListTile(
                       leading: CircleAvatar(
                        backgroundImage: AssetImage(location.image),
                        radius: 25,
                    ),
                    title: Text(location.name),
                    ),
                    ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  final Function(String) onQueryChanged;
  SearchBar({required this.onQueryChanged});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String query = '';

  void onQueryChanged(String newQuery) {
    setState(() {
      query = newQuery;
    });
    widget.onQueryChanged(newQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: TextField(
        onChanged: onQueryChanged,
        decoration: InputDecoration(
          labelText: 'Search',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
