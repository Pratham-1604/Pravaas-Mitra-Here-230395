import 'package:here/models/places_model.dart';

class UserModel {
  final String userId;
  final String name;
  final String email;
  final String phone;
  final String userAddress;
  final List<PlacesModel>? favourites;

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.userAddress,
    this.favourites,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'email': email,
      'phone': phone,
      'userAddress': userAddress,
      'favourites': favourites!=null ? favourites!.map((x) => x.toMap()).toList() : [],
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      userAddress: map['userAddress'] as String,
      favourites: map['favourites'] != null ? List<PlacesModel>.from((map['favourites'] as List<int>).map<PlacesModel?>((x) => PlacesModel.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }
}
