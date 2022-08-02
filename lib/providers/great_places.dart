import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';

import '../helpers/db_helper.dart';
import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  UnmodifiableListView<Place> get items {
    return UnmodifiableListView(_items);
  }

  void addPlace({required String title, required File image}) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      location: null,
      image: image,
    );

    _items.add(newPlace);

    notifyListeners();

    DBHelper.insert(DBHelper.tablePlaces, {
      DBHelper.columnId: newPlace.id,
      DBHelper.columnTitle: newPlace.title,
      DBHelper.columnImage: newPlace.image.path,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData(DBHelper.tablePlaces);
    _items = dataList
        .map(
          (p) => Place(
            id: p[DBHelper.columnId],
            title: p[DBHelper.columnTitle],
            location: null,
            image: File(p[DBHelper.columnImage]),
          ),
        )
        .toList();

    notifyListeners();
  }
}
