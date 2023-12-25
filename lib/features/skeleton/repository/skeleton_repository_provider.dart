// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import 'package:here_sdk/core.dart';
import 'package:here_sdk/core.errors.dart';
import 'package:here_sdk/search.dart';

import '../../../models/city_model.dart';
import 'package:here/common_widget/common_snackbar.dart';

final SkeletonRepositoryProvider = Provider(
  (ref) => SkeletonRepository(),
);

class SkeletonRepository {
  CityModel? _city;

  set cityName(CityModel? a) {
    if (a != null) {
      _city = a;
    } else {
      debugPrint("a is null");
      _city = CityModel(name: "ABC", countryName: "EFG", info: "");
    }
  }

  Future<void> setCity(BuildContext context) async {
    try {
      GeoCoordinates a = await determinePosition(context);
      Map? s = await getAddressForCoordinates(a, context);
      CityModel newCity = CityModel(
        name: s?['city'] ?? "",
        countryName: s?['country'] ?? "",
        info: "",
      );

      cityName = newCity;
    } catch (error) {
      debugPrint("Error in setCity: $error");
    }
  }

  CityModel? getCurrentCity() {
    debugPrint("city name: $_city");
    return _city;
  }

  Future<GeoCoordinates> determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;
    final GeoCoordinates predefined = GeoCoordinates(
      18.516726,
      73.856255,
    );
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
    GeoCoordinates geo = GeoCoordinates(a.latitude, a.longitude);
    return geo;
  }

  Future<Map?> getAddressForCoordinates(
    GeoCoordinates geoCoordinates,
    BuildContext context,
  ) async {
    Completer<Map?> completer = Completer<Map?>();

    try {
      SearchEngine searchEngine = SearchEngine();
      SearchOptions reverseGeocodingOptions = SearchOptions();
      reverseGeocodingOptions.languageCode = LanguageCode.enGb;
      reverseGeocodingOptions.maxItems = 1;

      searchEngine.searchByCoordinates(
        geoCoordinates,
        reverseGeocodingOptions,
        (SearchError? searchError, List<Place>? list) async {
          if (searchError != null) {
            showsnackbar(
              context: context,
              msg: "Reverse geocoding Error: $searchError",
            );
            completer.completeError(searchError.toString());
          } else {
            if (list != null && list.isNotEmpty) {
              String city = list.first.address.city;
              String country = list.first.address.country;
              final data = {
                "city": city,
                "country": country,
              };
              completer.complete(data);
            } else {
              completer.completeError("No address found.");
            }
          }
        },
      );

      // Wait for the asynchronous operation to complete
      return completer.future;
    } on InstantiationException {
      showsnackbar(context: context, msg: 'Instantiation exception');
      throw Exception("Initialization of SearchEngine failed.");
    } catch (err) {
      showsnackbar(context: context, msg: err.toString());
      throw Exception("Error while searching: $err");
    }
  }
}
