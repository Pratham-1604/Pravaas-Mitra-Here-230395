import 'package:here/models/places_thumbnail_modell.dart';

class CityModel {
  final String name;
  final String info;
  final String famousFor;
  final List<PlaceThumbnailModel> places;

  CityModel({
    required this.name,
    required this.info,
    required this.famousFor,
    required this.places,
  });
}
