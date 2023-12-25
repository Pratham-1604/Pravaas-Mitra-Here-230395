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
  SearchEngine? _searchEngine;

  SkeletonRepository() {
    try {
      _searchEngine = SearchEngine();
    } on InstantiationException {
      throw Exception("Initialization of SearchEngine failed.");
    }
  }

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
      await determinePosition(context);
      Map? s = await getAddressForCoordinates(context);
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

  Future<void> determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showsnackbar(context: context, msg: 'Pls allow location services!');
        permission = await Geolocator.requestPermission();
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      showsnackbar(context: context, msg: 'Permissions denied forever!');

      // Set default coordinates or handle as needed
      _geoCoordinates = GeoCoordinates(18.516726, 73.856255);
      return;
    }

    // Continue with normal flow
    Position a = await Geolocator.getCurrentPosition();
    GeoCoordinates geo = GeoCoordinates(a.latitude, a.longitude);
    geoCoordinates = geo;
  }

  Future<Map?> getAddressForCoordinates(
    BuildContext context,
  ) async {
    Completer<Map?> completer = Completer<Map?>();

    SearchOptions reverseGeocodingOptions = SearchOptions();
    reverseGeocodingOptions.languageCode = LanguageCode.enGb;
    reverseGeocodingOptions.maxItems = 1;

    if (_geoCoordinates == null) {
      showsnackbar(context: context, msg: 'geocoordinates null');
      // return "";
    }

    _searchEngine!.searchByCoordinates(
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
  }

  void getPlaces({
    required List<PlaceCategory> categoryList,
    required BuildContext context,
    required numberOfItems,
  }) {
    var queryArea = CategoryQueryArea.withCenter(_geoCoordinates!);
    CategoryQuery categoryQuery = CategoryQuery.withCategoriesInArea(
      categoryList,
      queryArea,
    );

    SearchOptions searchOptions = SearchOptions();
    searchOptions.languageCode = LanguageCode.enUs;
    searchOptions.maxItems = numberOfItems;

    _searchEngine!.searchByCategory(categoryQuery, searchOptions,
        (SearchError? searchError, List<Place>? list) async {
      if (searchError != null) {
        // Handle error.
        return;
      }

      // If error is null, list is guaranteed to be not empty.
      int listLength = list!.length;

      // showsnackbar(context: context, msg: '$listLength');

      // Add new marker for each search result on map.
      for (Place searchResult in list) {
        debugPrint(
            "${searchResult.title}, ${searchResult.details.ratings.length}");
        // debugPrint("${searchResult.details.}");
      }
      return;
    });
  }

  String categoryToString(String cat) {
    switch (cat) {
      case 'Locations':
        return PlaceCategory.sightsLandmarkAttaction;
      case 'Hotels':
        return PlaceCategory.goingOutEntertainment;
      case 'Food':
        return PlaceCategory.eatAndDrinkRestaurant;
      case 'Adventure':
        return PlaceCategory.naturalAndGeographical;
      case 'Parks':
        return PlaceCategory.facilitiesVenueSports;
      default:
        return 'all';
    }
  }

  void specificCategory({
    required String category,
    required BuildContext context,
  }) {
    String currCat = categoryToString(category);
    if (currCat == 'all') {
      popularCategories(context: context);
      return;
    }

    getPlaces(
        categoryList: [PlaceCategory(currCat)],
        context: context,
        numberOfItems: 5);
  }

  void popularCategories({required BuildContext context}) {
    List<PlaceCategory> categoryList = [];
    // categoryList.add(PlaceCategory(PlaceCategory.eatAndDrink));
    categoryList.add(PlaceCategory(PlaceCategory.sightsLandmarkAttaction));
    categoryList.add(PlaceCategory(PlaceCategory.goingOutEntertainment));
    categoryList.add(PlaceCategory(PlaceCategory.eatAndDrinkRestaurant));
    categoryList.add(PlaceCategory(PlaceCategory.naturalAndGeographical));
    categoryList.add(PlaceCategory(PlaceCategory.facilitiesVenueSports));

    if (_geoCoordinates == null) {
      showsnackbar(context: context, msg: "geocoordinates null");
      return;
    }

    for (var category in categoryList) {
      getPlaces(
        categoryList: [category],
        context: context,
        numberOfItems: 5,
      );
    }
  }
}
