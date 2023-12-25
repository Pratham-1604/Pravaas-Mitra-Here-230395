// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import 'package:here_sdk/core.dart';
import 'package:here_sdk/core.errors.dart';
import 'package:here_sdk/search.dart';

import '../../../models/city_model.dart';
import 'package:here/common_widget/common_snackbar.dart';


final HomePageRepositoryProvider = Provider(
  (ref) => HomePageRepository(),
);

class HomePageRepository {
  CityModel? _city;

  Future<void> setCity(BuildContext context) async {
    //   Map<String, double> position = await determinePosition(context);
    //   debugPrint("set current city repository");

    //   // process and get output
    //   try {
    //     const String url = 'https://2cc5-34-125-215-183.ngrok-free.app/city';
    //     final Map<String, dynamic> requestBody = {
    //       "latitude": position["latitude"],
    //       "longitude": position["longitude"],
    //     };

    //     final response = await http.post(
    //       Uri.parse(url),
    //       body: jsonEncode(requestBody),
    //       headers: {
    //         'Content-Type': 'application/json',
    //       },
    //     );
    //     Map<String, dynamic> jsonResponse;
    //     if (response.statusCode == 200) {
    //       jsonResponse = jsonDecode(response.body);
    //       debugPrint("Successful CITYNAME API");
    //       showsnackbar(context: context, msg: "Successful CITYNAME API");
    //     } else {
    //       String jsonString = await rootBundle
    //           .loadString('assets/default_data/city_default_data.json');
    //       jsonResponse = jsonDecode(jsonString);
    //       debugPrint("loaded default string");
    //       showsnackbar(context: context, msg: "loaded default string");
    //     }

    //     CityModel c = CityModel(
    //       name: jsonResponse['city'],
    //       countryName: jsonResponse['country'],
    //       info: jsonResponse['info'],
    //       places: (jsonResponse['places'] as List).map((place) {
    //         return PlacesModel(
    //           name: place['name'] as String,
    //           info: place['info'] as String,
    //           address: place['address'] as String,
    //           website: place['website'] as String?,
    //           images: place['images'] as String,
    //           ratings: place['ratings'] as num,
    //           latitude: place['latitude'] as double,
    //           longitude: place['longitude'] as double,
    //           emails: place['emails'] as String?,
    //           phoneNumber: place['phoneNumber'] as String?,
    //         );
    //       }).toList(),
    //     );
    //     _city = c;
    //   } catch (e) {
    //     debugPrint("ERROR_CITY_NAME_API , ${e.toString()}");
    //   }
  }

  CityModel? getCurrentCity() {
    debugPrint("get current city repository");
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

  Future<String> getAddressForCoordinates(
    GeoCoordinates geoCoordinates,
    BuildContext context,
  ) async {
    try {
      SearchEngine searchEngine = SearchEngine();
      SearchOptions reverseGeocodingOptions = SearchOptions();
      reverseGeocodingOptions.languageCode = LanguageCode.enGb;
      reverseGeocodingOptions.maxItems = 1;
      String s = "";
      searchEngine.searchByCoordinates(geoCoordinates, reverseGeocodingOptions,
          (SearchError? searchError, List<Place>? list) async {
        if (searchError != null) {
          showsnackbar(
            context: context,
            msg: "Reverse geocoding Error: $searchError",
          );
          return;
        }
        s = list!.first.address.addressText;
        // If error is null, list is guaranteed to be not empty.
        showsnackbar(
          context: context,
          msg: "Reverse geocoded address: ${list.first.address.addressText}",
        );
      });
      return s;
    } on InstantiationException {
      showsnackbar(context: context, msg: 'Instantian exception');
      throw Exception("Initialization of SearchEngine failed.");
    } catch (err) {
      showsnackbar(context: context, msg: err.toString());
      return "Pune";
    }
  }
}
