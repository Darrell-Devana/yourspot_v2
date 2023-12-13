import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:yourspot_v2/models/horizontal_place_data.dart';
import 'package:yourspot_v2/widgets/horizontal_place_card.dart';

class MyHomePage extends StatefulWidget {
  static const String routeName = "/home";

  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  void signOut() async {
    await auth.signOut();
    () => Navigator.pushReplacementNamed(context, "/signin");
  }

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      centerTitle: false,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(17),
        child: Container(
          margin:
              const EdgeInsets.only(top: 12, bottom: 12, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Welcome back,",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    auth.currentUser!.displayName.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              InkWell(
                child: ProfilePicture(
                  name: '',
                  radius: 24,
                  fontsize: 18,
                  img: auth.currentUser!.photoURL,
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Confirm Sign Out'),
                      content: const Text('Are you sure you want to sign out?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            signOut();
                            Navigator.pop(context);
                          },
                          child: const Text('Sign Out'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: appbar,
      body: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 12.0, top: 18),
                child: Text(
                  'Favorites',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12.0, top: 18),
                child: InkWell(
                  onTap: () => Navigator.pushNamed(context, "/favorites"),
                  child: const Text(
                    'More',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18),
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return HorizontalPlaceCard(
                    id: placeList[index].id,
                    title: placeList[index].title,
                    imageUrl: placeList[index].imageUrl,
                    subtitle: placeList[index].subtitle,
                  );
                },
                itemCount: placeList.length,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 12.0, top: 18),
                child: Text(
                  'Locations',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12.0, top: 18),
                child: InkWell(
                  onTap: () => Navigator.pushNamed(context, "/locations"),
                  child: const Text(
                    'More',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18),
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return HorizontalPlaceCard(
                    id: placeList[index].id,
                    title: placeList[index].title,
                    imageUrl: placeList[index].imageUrl,
                    subtitle: placeList[index].subtitle,
                  );
                },
                itemCount: placeList.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}
