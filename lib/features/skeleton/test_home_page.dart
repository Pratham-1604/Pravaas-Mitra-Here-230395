// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:here/common_widget/loader.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/core.errors.dart';
import 'package:here_sdk/search.dart';

import '../../common_widget/common_snackbar.dart';

class TestHomePage extends StatefulWidget {
  const TestHomePage({super.key});

  static const routeName = '/testhomepage';

  @override
  State<TestHomePage> createState() => _TestHomePageState();
}

class _TestHomePageState extends State<TestHomePage> {
  bool isLoading = false;
  String? address;

  void searchForCategories(GeoCoordinates geo) {
    try {
      SearchEngine searchEngine = SearchEngine();

      List<PlaceCategory> categoryList = [];
      // categoryList.add(PlaceCategory(PlaceCategory.eatAndDrink));
      categoryList.add(PlaceCategory(PlaceCategory.sightsAndMuseums));

      var queryArea = CategoryQueryArea.withCenter(geo);
      CategoryQuery categoryQuery = CategoryQuery.withCategoriesInArea(
        categoryList,
        queryArea,
      );

      SearchOptions searchOptions = SearchOptions();
      searchOptions.languageCode = LanguageCode.enUs;
      searchOptions.maxItems = 20;

      searchEngine.searchByCategory(categoryQuery, searchOptions,
          (SearchError? searchError, List<Place>? list) async {
        if (searchError != null) {
          // Handle error.
          return;
        }

        // If error is null, list is guaranteed to be not empty.
        int listLength = list!.length;

        showsnackbar(context: context, msg: '$listLength');

        // Add new marker for each search result on map.
        for (Place searchResult in list) {
          debugPrint(searchResult.title);
        }

        return;
      });
    } on InstantiationException {
      throw Exception("Initialization of SearchEngine failed.");
    }
  }

  Future<void> getAddressForCoordinates(GeoCoordinates geoCoordinates) async {
    try {
      SearchEngine searchEngine = SearchEngine();
      SearchOptions reverseGeocodingOptions = SearchOptions();
      reverseGeocodingOptions.languageCode = LanguageCode.enGb;
      reverseGeocodingOptions.maxItems = 1;

      searchEngine.searchByCoordinates(geoCoordinates, reverseGeocodingOptions,
          (SearchError? searchError, List<Place>? list) async {
        if (searchError != null) {
          showsnackbar(
            context: context,
            msg: "Reverse geocoding Error: $searchError",
          );
          return;
        }

        // If error is null, list is guaranteed to be not empty.
        showsnackbar(
          context: context,
          msg: "Reverse geocoded address: ${list!.first.address.addressText}",
        );
        setState(() {
          address = list.first.address.addressText;
        });
      });
      
    } on InstantiationException {
      showsnackbar(context: context, msg: 'Instantian exception');
      throw Exception("Initialization of SearchEngine failed.");
    } catch (err) {
      showsnackbar(context: context, msg: err.toString());
    }
  }

  Future<GeoCoordinates> determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;
    final GeoCoordinates predefined = GeoCoordinates(
      18.516726,
      73.856255,
    );

    setState(() {
      isLoading = true;
    });

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
      setState(() {
        isLoading = false;
      });
      return predefined;
    }
    Position a = await Geolocator.getCurrentPosition();
    GeoCoordinates geo = GeoCoordinates(a.latitude, a.longitude);
    setState(() {
      isLoading = false;
    });
    return geo;
  }

  GeoCoordinates? a;

  void setA() async {
    a = await determinePosition(context);
  }

  void getLocation() async {
    if (a != null) await getAddressForCoordinates(a!);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Hey'),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    setA();
                  });
                },
                child: Text('Press'),
              ),
              if (isLoading) LoaderWidget(),
              if (a != null) Text('${a!.latitude}, ${a!.longitude}'),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    getLocation();
                  });
                },
                child: Text('Press2'),
              ),
              if (address != null) Text(address!),
              ElevatedButton(
                onPressed: () {
                  searchForCategories(a!);
                },
                child: Text('Press3'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
