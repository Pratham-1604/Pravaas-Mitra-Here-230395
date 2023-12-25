// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:here/features/skeleton/repository/home_page_repository_provider.dart';
import 'package:here/models/city_model.dart';
import 'package:here_sdk/core.dart';

final HomePageControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(HomePageRepositoryProvider);
  return HomePageController(chatRepository, ref);
});

class HomePageController {
  final HomePageRepository homePageRepository;
  final ProviderRef ref;

  HomePageController(
    this.homePageRepository,
    this.ref,
  );

  CityModel? getCityDetails() {
    debugPrint("get current city contoller");
    return homePageRepository.getCurrentCity();
  }

  Future<void> setCurrentCity(BuildContext context) {
    debugPrint("set current city contoller");
    return homePageRepository.setCity(context);
  }

  Future<GeoCoordinates> getCurrentPosition(BuildContext context) {
    return homePageRepository.determinePosition(context);
  }
}
