import 'places_model.dart';

class CityModel {
  final String name;
  final String countryName;
  final String info;
  final List<PlacesModel> places;

  CityModel({
    required this.name,
    required this.countryName,
    required this.info,
    required this.places,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    List<PlacesModel> convertedPlaces = [];
    if (json['places'] != null) {
      convertedPlaces = (json['places'] as List).map((place) {
        return PlacesModel(
          name: place['name'] as String,
          info: place['info'] as String,
          address: place['address'] as String,
          website: place['website'] as String?,
          images: place['images'] as String,
          ratings: place['ratings'] as double,
          latitude: place['latitude'] as double,
          longitude: place['longitude'] as double,
          emails: place['emails'] as String?,
          phoneNumber: place['phoneNumber'] as String?,
        );
      }).toList();
    }

    return CityModel(
      name: json['city'] as String,
      countryName: json['country'] as String,
      info: json['info'] as String,
      places: convertedPlaces,
    );
  }
}