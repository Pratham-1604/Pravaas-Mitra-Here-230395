class PlacesModel {
  final String name;
  final String info;
  final String address;
  final String? website;
  final String images;
  // final List<String> reviews;
  final double ratings;
  final double latitude;
  final double longitude;
  final String? emails;
  final String? phoneNumber;

  PlacesModel({
    required this.name,
    required this.info,
    required this.images,
    // required this.reviews,
    required this.ratings,
    required this.latitude,
    required this.longitude,
    required this.address, 
    this.emails,
    this.phoneNumber,
    this.website,
  });
}
