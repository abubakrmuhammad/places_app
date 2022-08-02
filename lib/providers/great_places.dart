import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  final List<Place> _items = [];

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
  }
}
