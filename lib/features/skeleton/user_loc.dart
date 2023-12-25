import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:here/common_widget/loader.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/core.errors.dart';
import 'package:here_sdk/search.dart';

class UserLocUtils {
  Future<String> getCityName() async {
    bool serviceEnabled;
    LocationPermission permission;
    final GeoCoordinates predefined = GeoCoordinates(
      18.516726,
      73.856255,
    );

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return _getCityNameFromCoordinates(predefined);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
    }

    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      return _getCityNameFromCoordinates(predefined);
    }

    Position currentPosition = await Geolocator.getCurrentPosition();
    GeoCoordinates currentCoordinates = GeoCoordinates(
      currentPosition.latitude,
      currentPosition.longitude,
    );

    return _getCityNameFromCoordinates(currentCoordinates);
  }

  Future<String> _getCityNameFromCoordinates(GeoCoordinates coordinates) async {
    try {
      SearchEngine searchEngine = SearchEngine();
      SearchOptions reverseGeocodingOptions = SearchOptions();
      reverseGeocodingOptions.languageCode = LanguageCode.enGb;
      reverseGeocodingOptions.maxItems = 1;

      Completer<String> completer = Completer<String>();

      searchEngine.searchByCoordinates(
        coordinates,
        reverseGeocodingOptions,
        (SearchError? searchError, List<Place>? list) {
          if (searchError != null) {
            completer.complete('');
            return;
          }

          if (list != null && list.isNotEmpty) {
            completer.complete(list.first.address.city ?? '');
          } else {
            completer.complete('');
          }
        },
      );

      return completer.future;
    } on InstantiationException {
      throw Exception("Initialization of SearchEngine failed.");
    } catch (err) {
      return '';
    }
  }
}

  

