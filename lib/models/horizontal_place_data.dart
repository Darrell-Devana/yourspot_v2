class HorizontalPlace {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;

  HorizontalPlace(
      {required this.id,
      required this.title,
      required this.subtitle,
      required this.imageUrl});
}

List<HorizontalPlace> horizontalPlaceList = [
  HorizontalPlace(
    id: 'm1',
    title: 'Syahdan Campus',
    subtitle: 'Jakarta Barat',
    imageUrl:
        'https://binus.ac.id/wp-content/uploads/2019/08/WhatsApp-Image-2020-09-24-at-3.47.56-PM-1.jpeg',
  ),
  HorizontalPlace(
    id: 'm2',
    title: 'Anggrek Campus',
    subtitle: 'Jakarta Barat',
    imageUrl:
        'https://asset.kompas.com/crops/fvqMvMySQjR95wrLA7322443JnU=/0x0:1280x853/750x500/data/photo/2021/04/20/607edfd535849.jpeg',
  ),
  HorizontalPlace(
    id: 'm3',
    title: 'Kijang Campus',
    subtitle: 'Jakarta Barat',
    imageUrl:
        'https://binus.ac.id/wp-content/uploads/2019/08/WhatsApp-Image-2020-09-24-at-3.47.59-PM-2.jpeg',
  ),
];

List<HorizontalPlace> horizontalFavoritePlaceList = [];
