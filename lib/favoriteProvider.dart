import 'package:flutter/material.dart';
import 'models/vertical_place_data.dart';
import 'models/horizontal_place_data.dart';

class FavoritePlacesProvider extends ChangeNotifier {
  final List<VerticalPlace> _verticalFavoritePlaceList = [];
  final List<HorizontalPlace> _horizontalFavoritePlaceList = [];

  List<VerticalPlace> get verticalFavoritePlaceList =>
      _verticalFavoritePlaceList;
  List<HorizontalPlace> get horizontalFavoriteList =>
      _horizontalFavoritePlaceList;

  void addFavorite(
      VerticalPlace verticalPlace, HorizontalPlace horizontalPlace) {
    _verticalFavoritePlaceList.add(verticalPlace);
    _horizontalFavoritePlaceList.add(horizontalPlace);
    notifyListeners();
  }

  void removeFavorite(String id) {
    _verticalFavoritePlaceList.removeWhere((place) => place.id == id);
    _horizontalFavoritePlaceList.removeWhere((place) => place.id == id);
    notifyListeners();
  }

  bool isFavoriteVertical(String id) {
    return _verticalFavoritePlaceList.indexWhere((place) => place.id == id) !=
        -1;
  }

  bool isFavoriteHorizontal(String id) {
    return _horizontalFavoritePlaceList.indexWhere((place) => place.id == id) !=
        -1;
  }
}
