import 'package:here/models/places_model.dart';

class UserModel {
  final String name;
  final String email;
  final String phone;
  final String userAddress;
  final List<PlacesModel>? favourites;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.userAddress,
    this.favourites,
  });
}
