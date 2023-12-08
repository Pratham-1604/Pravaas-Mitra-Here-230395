import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:here/models/city_model.dart';
import 'package:http/http.dart' as http;

import '../../../models/places_model.dart';

final HomePageRepositoryProvider = Provider(
  (ref) => HomePageRepository(),
);

class HomePageRepository {
  late CityModel _city;

  set cityData(CityModel cityData) {
    _city = cityData;
  }

  Future<void> setCity() async {
    Position position = await _determinePosition();
    // process and get output
    try {
      const String url = 'https://c6c9-150-242-204-196.ngrok-free.app/city';
      final Map<String, dynamic> requestBody = {
        "latitude": position.latitude,
        "longitude": position.longitude,
      };

      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(requestBody),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        debugPrint("Successful CITYNAME API ${response.body}");
// Parse the JSON response into CityModel
        CityModel c = CityModel(
          name: jsonResponse['city'],
          countryName: jsonResponse['country'],
          info: jsonResponse['info'],
          places: List<PlacesModel>.from(
            (jsonResponse['places'] as List).map(
              (place) => PlacesModel(
                name: place['name'] as String,
                info: place['info'] as String,
                address: place['address'] as String,
                website: place['website'] as String?,
                images: List<String>.from(place['images'] as List),
                reviews: List<String>.from(place['reviews'] as List),
                ratings: place['ratings'] as double,
                latitude: place['latitude'] as double,
                longitude: place['longitude'] as double,
                emails: (place['emails'] as List?)
                        ?.map((item) => item as String)
                        .toList() ?? [],
                phoneNumber: (place['phoneNumber'] as List?)
                        ?.map((item) => item as String)
                        .toList() ?? [],
              ),
            ),
          ),
        );
        cityData = c;
      } else {
        CityModel c = CityModel(
          name: 'DBC',
          countryName: 'IND',
          info: "Hello ",
          places: [],
        );
        cityData = c;
      }
    } catch (e) {
      debugPrint("ERROR_CITY_NAME_API , ${e.toString()}");
    }
  }

  CityModel getCurrentCity() {
    return _city;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
