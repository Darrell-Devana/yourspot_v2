import 'package:flutter/material.dart';
import '../screens/place_detail.dart';

class HorizontalPlaceCard extends StatelessWidget {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;

  const HorizontalPlaceCard({
    super.key,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.subtitle,
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
        elevation: 2,
        child: SizedBox(
          height: double.infinity,
          width: 200,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 8),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        subtitle,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
