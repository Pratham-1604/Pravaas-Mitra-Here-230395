import 'package:flutter/material.dart';
import 'package:here_sdk/search.dart';

import 'package:here_sdk/core.dart';

class NewCity extends ChangeNotifier {
  List<Map> searchResult = [];
  bool isSearching = false;

  Future<void> searchPlace(String query) async {
    isSearching = true;
    notifyListeners();
    SearchEngine searchEngine = SearchEngine();
    SearchOptions searchOptions = SearchOptions();
    // TODO: replace with users current coordinates
    GeoCircle geoCircle = GeoCircle(
        GeoCoordinates(19.13467459875586, 72.91231098205164), 100000000);
    TextQueryArea queryArea = TextQueryArea.withCircle(geoCircle);
    TextQuery squery = TextQuery.withArea(query, queryArea);
    List<Map> res = [];
    searchEngine.suggest(squery, searchOptions, (p0, p1) async {
      if (p1 == null) {
        return;
      }
      for (var i = 0; i < p1.length; i++) {
        final place = p1[i].place;
        final title = p1[i].title;
        final address = place!.address;
        final addressText = address.addressText;
        final geoCoordinates = place.geoCoordinates;
        final latitude = geoCoordinates!.latitude;
        final longitude = geoCoordinates.longitude;
        final data = {
          "title": title,
          "address": addressText,
          "latitude": latitude,
          "longitude": longitude,
        };
        res.add(data);
      }
      // isSearching = false;
      await Future.delayed(const Duration(seconds: 1));
      searchResult = res;
      isSearching = false;
      notifyListeners();
    });
  }
}
