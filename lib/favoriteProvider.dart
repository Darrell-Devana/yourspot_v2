import 'package:flutter/material.dart';
import 'models/vertical_place_data.dart';

class FavoritePlacesProvider extends ChangeNotifier {
  final List<VerticalPlace> _favoritePlaceList = [];

  List<VerticalPlace> get favoritePlaceList => _favoritePlaceList;

  void addFavorite(VerticalPlace place) {
    _favoritePlaceList.add(place);
    notifyListeners();
  }

  void removeFavorite(String id) {
    _favoritePlaceList.removeWhere((place) => place.id == id);
    notifyListeners();
  }

  bool isFavorite(String id) {
    return _favoritePlaceList.indexWhere((place) => place.id == id) != -1;
  }
}
