import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yourspot_v2/widgets/vertical_place_card.dart';
import 'package:yourspot_v2/models/vertical_place_data.dart';

class LocationsPage extends StatefulWidget {
  static const String routeName = "/locations";
  final String title;

  const LocationsPage({
    super.key,
    required this.title,
  });

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  String getStatusText(bool isAvailable) {
    return isAvailable ? 'Unavailable' : 'Available';
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final place = placeList;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          widget.title,
        ),
        actions: [
          IconButton(
            onPressed: () {
              signOut();
            },
            icon: const Icon(Icons.logout),
            color: Colors.white,
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return VerticalPlaceCard(
            id: place[index].id,
            title: place[index].title,
            imageUrl: place[index].imageUrl,
            availability: place[index].availability,
          );
        },
        itemCount: place.length,
      ),
    );
  }

  void signOut() async {
    await auth.signOut();
    () => Navigator.pushReplacementNamed(context, "/signin");
  }
}
