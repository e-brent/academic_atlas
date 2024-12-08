import 'package:flutter/material.dart';
import 'package:academic_atlas/view_model/location_list_view_model.dart';
import 'package:academic_atlas/widgets/locations_list.dart';

import 'package:provider/provider.dart';

class LocationListView extends StatefulWidget {
  @override
  _LocationListViewState createState() => _LocationListViewState();
}

class _LocationListViewState extends State<LocationListView> {

  @override
  void initState() {
    super.initState();
    Provider.of<LocationListViewModel>(context, listen: false).fetchLocations();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LocationListViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Locations List", style: Theme.of(context).textTheme.titleMedium)
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: (Column( children: <Widget> [
          Expanded(
            child: ListView.builder(
              itemCount: vm.locations.length,
              itemBuilder: (context,index){
                final location = vm.locations[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context,'/details',arguments:location.id,);
                },
                child: Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                        location.image
                      ),
                    radius: 25,
                    ),
                    title:Text(location.name),
                    trailing: IconButton(
                        icon: Icon(
                          location.isFavorite ? Icons.star : Icons.star_border,
                          color: location.isFavorite ? Colors.yellow : Colors.grey,
                        ),
                        onPressed: () {
                          //add logic here later for DEv-4
                          setState(() {
                            location.setIsFavorite(!location.isFavorite);
                          });
                        },
                        ),
                    tileColor: Colors.purple.shade50,
                    selectedTileColor: Colors.deepPurple.shade100,
                  ),

                ),
                );
              }



            ),
          ),
        ])
        ),
      ),
    );
  }
}
