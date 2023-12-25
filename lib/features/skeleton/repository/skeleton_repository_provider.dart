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
      String? s = await getAddressForCoordinates(a, context);
      debugPrint("success");
      debugPrint(s.toString());

      // Split the addressText by commas and trim each word
      List<String> words = s?.split(',').map((e) => e.trim()).toList() ?? [];

      // Extract the last two words
      List<String> lastTwoWords = words.length > 1
          ? [words[words.length - 2].split(" ").first, words.last]
          : []; // If there are fewer than two words, an empty list is returned

      CityModel newCity = CityModel(
        name: lastTwoWords[0],
        countryName: lastTwoWords[1],
        info: "",
      );

      cityName = newCity;

      // Output the last two words
      debugPrint("Last two words: $lastTwoWords");
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

  Future<String?> getAddressForCoordinates(
    GeoCoordinates geoCoordinates,
    BuildContext context,
  ) async {
    Completer<String?> completer = Completer<String?>();

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
              String addressText = list.first.address.addressText;
              debugPrint("Address: $addressText");

              completer.complete(addressText);
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
      return "Pune";
    }
  }
}
