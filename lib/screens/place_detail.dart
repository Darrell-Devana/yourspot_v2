import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:yourspot_v2/models/horizontal_place_data.dart';
import 'package:yourspot_v2/models/vertical_place_data.dart';
import 'package:yourspot_v2/favoriteProvider.dart';
import 'package:provider/provider.dart';

class PlaceDetail extends StatefulWidget {
  static const String routeName = '/placedetail';

  const PlaceDetail({super.key});

  @override
  State<PlaceDetail> createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetail> {
  final databaseRef = FirebaseDatabase.instance.ref();
  var favoriteIcon = const Icon(Icons.star_border);

  @override
  void initState() {
    super.initState();
  }

  void _addToFavorite(
      String id, FavoritePlacesProvider favoritePlacesProvider) {
    int verticalIndex = favoritePlacesProvider.verticalFavoritePlaceList
        .indexWhere((place) => place.id == id);
    int horizontalIndex = favoritePlacesProvider.horizontalFavoriteList
        .indexWhere((place) => place.id == id);

    if (verticalIndex != -1 && horizontalIndex != -1) {
      favoritePlacesProvider.removeFavorite(id);
      favoriteIcon = const Icon(Icons.star_border);
    } else {
      int placeIndex = verticalPlaceList.indexWhere((place) => place.id == id);

      if (placeIndex != -1) {
        favoritePlacesProvider.addFavorite(
            verticalPlaceList[placeIndex], horizontalPlaceList[placeIndex]);
        favoriteIcon = const Icon(Icons.star);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>?;
    final String placeId = routeArgs!['id'].toString();
    final String placeImageUrl = routeArgs['imageUrl'].toString();

    final selectedPlace =
        verticalPlaceList.firstWhere((place) => place.id == placeId);
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        selectedPlace.title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      actions: [
        Consumer<FavoritePlacesProvider>(
          builder: (context, favoritePlacesProvider, child) {
            return IconButton(
              onPressed: () => _addToFavorite(placeId, favoritePlacesProvider),
              icon: favoritePlacesProvider.isFavoriteVertical(placeId)
                  ? const Icon(Icons.star)
                  : const Icon(Icons.star_border),
            );
          },
        )
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SizedBox(
        height: mediaQuery.size.height,
        child: StreamBuilder(
          stream: databaseRef.child('Syahdan').onValue,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
              dynamic data = snapshot.data!.snapshot.value;

              List<String> parkingSpaceIds = data.keys.toList().cast<String>();
              List<dynamic> historyData = data.values.toList();

              List<Map<String, dynamic>> sortedData = [];
              for (int i = 0; i < parkingSpaceIds.length; i++) {
                sortedData.add({
                  'id': parkingSpaceIds[i],
                  'history': historyData[i],
                });
              }
              sortedData.sort((a, b) => a['id'].compareTo(b['id']));

              parkingSpaceIds =
                  sortedData.map((e) => e['id'] as String).toList();
              historyData = sortedData.map((e) => e['history']).toList();

              int availableSpaces =
                  historyData.where((data) => data.toString() == 'true').length;

              return Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.6),
                            BlendMode.darken,
                          ),
                          child: SizedBox(
                            height: mediaQuery.size.height * 0.2,
                            width: mediaQuery.size.width,
                            child: Image.network(
                              placeImageUrl.toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: 430,
                          color: Colors.black45,
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Available Spaces: $availableSpaces / ${parkingSpaceIds.length}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                              const Icon(Icons.car_repair)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    child: ListView.builder(
                      itemCount: parkingSpaceIds.length,
                      itemBuilder: (context, index) {
                        String parkingSpaceId = parkingSpaceIds[index];

                        return Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, bottom: 8),
                            child: ListTile(
                              title: Text(
                                parkingSpaceId,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              trailing: Text(
                                historyData[index].toString() == 'true'
                                    ? 'Available'
                                    : 'Unavailable',
                                style: TextStyle(
                                  color: historyData[index].toString() == 'true'
                                      ? const Color.fromARGB(255, 49, 255, 56)
                                      : const Color.fromARGB(255, 255, 44, 29),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: historyData[index].toString() == 'true'
                                      ? Colors.green
                                      : Colors.red,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ));
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
