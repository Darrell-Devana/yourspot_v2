import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yourspot_v2/widgets/vertical_place_card.dart';
import 'package:yourspot_v2/models/vertical_place_data.dart';
import 'package:provider/provider.dart';
import 'package:yourspot_v2/favoriteProvider.dart';

class FavoritesPage extends StatefulWidget {
  static const String routeName = "/favorites";
  final String title;

  const FavoritesPage({
    super.key,
    required this.title,
  });

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  FocusNode focusNode = FocusNode();
  List<VerticalPlace> filteredPlaces = [];

  String getStatusText(bool isAvailable) {
    return isAvailable ? 'Unavailable' : 'Available';
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final favoritePlacesProvider = Provider.of<FavoritePlacesProvider>(context);
    final place = favoritePlacesProvider.verticalFavoritePlaceList;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 5,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: TextField(
              keyboardType: TextInputType.text,
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: 'Search',
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (value) {
                focusNode.requestFocus();
                List<VerticalPlace> filteredList = favoritePlacesProvider
                    .verticalFavoritePlaceList
                    .where((place) =>
                        place.title.toLowerCase().contains(value.toLowerCase()))
                    .toList();
                setState(() {
                  filteredPlaces = filteredList;
                });
              },
              onSubmitted: (value) {
                focusNode.unfocus();
              },
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return VerticalPlaceCard(
            id: filteredPlaces.isNotEmpty
                ? filteredPlaces[index].id
                : place[index].id,
            title: filteredPlaces.isNotEmpty
                ? filteredPlaces[index].title
                : place[index].title,
            imageUrl: filteredPlaces.isNotEmpty
                ? filteredPlaces[index].imageUrl
                : place[index].imageUrl,
            availability: filteredPlaces.isNotEmpty
                ? filteredPlaces[index].availability
                : place[index].availability,
          );
        },
        itemCount:
            filteredPlaces.isNotEmpty ? filteredPlaces.length : place.length,
      ),
    );
  }

  void signOut() async {
    await auth.signOut();
    () => Navigator.pushReplacementNamed(context, "/signin");
  }
}
