import 'places_thumbnail_modell.dart';

class CityModel {
  final String name;
  final String countryName;
  final String info;
  final List<PlaceThumbnailModel> places;

  CityModel({
    required this.name,
    required this.countryName,
    required this.info,
    required this.places,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    // Convert each inner list into a PlaceThumbnailModel
    List<PlaceThumbnailModel> convertedPlaces = (json['places'] as List).map((place) {
      return PlaceThumbnailModel(
        name: place[0] as String,
        image: place[1] as String,
        rating: place[2] as double,
        isFavourite: place[3] as bool,
      );
    }).toList();

    return CityModel(
      name: json['city'] as String,
      countryName: json['country'] as String,
      info: json['info'] as String,
      places: convertedPlaces,
    );
  }
}