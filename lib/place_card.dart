import 'package:flutter/material.dart';
import 'screens/place_detail.dart';

class PlaceCard extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int availability;

  const PlaceCard({
    super.key,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.availability,
  });

  void selectPlace(BuildContext context) {
    Navigator.of(context).pushNamed(
      PlaceDetail.routeName,
      arguments: {
        'id': id,
        'title': title,
        'imageUrl': imageUrl,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectPlace(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 10,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        // IconButton(
                        //   onPressed: toggleFavorite,
                        //   icon: Icon(
                        //     isFavorite ? Icons.favorite : Icons.favorite_border,
                        //     color: isFavorite ? Colors.red : Colors.white,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.car_repair),
                      const SizedBox(width: 6),
                      Text('$availability Spots'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
