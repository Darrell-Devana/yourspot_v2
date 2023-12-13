class VerticalPlace {
  final String id;
  final String title;
  final String imageUrl;
  final int availability;

  VerticalPlace(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.availability});
}

List<VerticalPlace> verticalPlaceList = [
  VerticalPlace(
    id: 'm1',
    title: 'Syahdan Campus',
    imageUrl:
        'https://binus.ac.id/wp-content/uploads/2019/08/WhatsApp-Image-2020-09-24-at-3.47.56-PM-1.jpeg',
    availability: 3,
  ),
  VerticalPlace(
    id: 'm2',
    title: 'Anggrek Campus',
    imageUrl:
        'https://asset.kompas.com/crops/fvqMvMySQjR95wrLA7322443JnU=/0x0:1280x853/750x500/data/photo/2021/04/20/607edfd535849.jpeg',
    availability: 15,
  ),
  VerticalPlace(
    id: 'm3',
    title: 'Kijang Campus',
    imageUrl:
        'https://binus.ac.id/wp-content/uploads/2019/08/WhatsApp-Image-2020-09-24-at-3.47.59-PM-2.jpeg',
    availability: 5,
  ),
];

List<VerticalPlace> verticalFavoritePlaceList = [];
