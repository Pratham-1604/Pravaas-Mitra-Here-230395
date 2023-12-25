// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:here/models/places_model.dart';

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
  List<PlacesModel>? _places;
  GeoCoordinates? _geoCoordinates;

  CityModel? getCurrentCity() {
    debugPrint("city name: $_city");
    return _city;
  }

  GeoCoordinates? getGeocoordinates() {
    debugPrint("geocoordinates getter: $_geoCoordinates");
    return _geoCoordinates;
  }

  set cityName(CityModel? a) {
    if (a != null) {
      _city = a;
    } else {
      debugPrint("a is null");
      _city = CityModel(name: "ABC", countryName: "EFG", info: "");
    }
  }

  set geoCoordinates(GeoCoordinates? geo) {
    if (geo != null) {
      _geoCoordinates = geo;
    } else {
      debugPrint("geocoordinates setter null");
      final GeoCoordinates predefined = GeoCoordinates(
        18.516726,
        73.856255,
      );
      _geoCoordinates = predefined;
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

      // Set the city
      cityName = newCity;
    } catch (error) {
      debugPrint("Error in setCity: $error");
    }
  }

  Future<GeoCoordinates> determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      
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
      // return;
    }
    Position a = await Geolocator.getCurrentPosition();
    GeoCoordinates geo = GeoCoordinates(a.latitude, a.longitude);
    geoCoordinates = geo;
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

      if (_geoCoordinates == null) {
        showsnackbar(context: context, msg: 'geocoordinates null');
        // return "";
      }

      searchEngine.searchByCoordinates(
        _geoCoordinates!,
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
