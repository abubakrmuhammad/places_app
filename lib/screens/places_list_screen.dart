import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';
import './add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : Consumer<GreatPlaces>(
                    builder: (context, places, child) => places.items.isEmpty
                        ? child!
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: ListView.builder(
                              itemCount: places.items.length,
                              itemBuilder: (context, index) => ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(places.items[index].image),
                                  radius: 50,
                                ),
                                title: Text(places.items[index].title),
                                onTap: () {
                                  // go to details page
                                },
                              ),
                            ),
                          ),
                    child: const Center(child: Text('No places added yet!')),
                  ),
      ),
    );
  }
}
