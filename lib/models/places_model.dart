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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'info': info,
      'address': address,
      'website': website,
      'images': images,
      'ratings': ratings,
      'latitude': latitude,
      'longitude': longitude,
      'emails': emails,
      'phoneNumber': phoneNumber,
    };
  }

  factory PlacesModel.fromMap(Map<String, dynamic> map) {
    return PlacesModel(
      name: map['name'] as String,
      info: map['info'] as String,
      address: map['address'] as String,
      website: map['website'] != null ? map['website'] as String : null,
      images: map['images'] as String,
      ratings: map['ratings'] as double,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      emails: map['emails'] != null ? map['emails'] as String : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
    );
  }

}
