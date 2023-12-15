import 'dart:convert';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:here/common_widget/common_snackbar.dart';
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

  Future<void> setCity(BuildContext context) async {
    Map<String, double> position = await determinePosition(context);
    // process and get output
    try {
      const String url = 'https://29e8-34-91-92-52.ngrok-free.app/city';
      final Map<String, dynamic> requestBody = {
        "latitude": position["latitude"],
        "longitude": position["longitude"],
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

        CityModel c = CityModel(
          name: jsonResponse['city'],
          countryName: jsonResponse['country'],
          info: jsonResponse['info'],
          places: (jsonResponse['places'] as List).map((place) {
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
          }).toList(),
        );

        cityData = c;
      } else {
        debugPrint('here');
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

  Future<Map<String, double>> determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;
    const Map<String, double> predefined = {
      "latitude": 18.516726 , 
      "longitude": 73.856255, 
    };
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return predefined;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showsnackbar(context: context, msg: 'Pls allow location services!');
        permission = await Geolocator.requestPermission();
      }
    }

    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      // Permissions are denied forever, handle appropriately.
      return predefined;
    }
    Position a = await Geolocator.getCurrentPosition();
    Map<String, double> defined = {"latitude": a.latitude, "longitude": a.longitude};
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return defined;
  }
}
