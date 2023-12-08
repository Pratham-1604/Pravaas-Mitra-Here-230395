// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:here/models/places_thumbnail_modell.dart';

class CityModel {
  final String name;
  final String countryName;
  final String info;
  final String famousFor;
  final List<PlaceThumbnailModel> places;

  CityModel({
    required this.name,
    required this.countryName,
    required this.info,
    required this.famousFor,
    required this.places,
  });
}
