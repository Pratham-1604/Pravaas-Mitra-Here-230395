// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:here/features/home_page/repository/home_page_repository_provider.dart';
import 'package:here/models/city_model.dart';

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

  CityModel getCityDetails() {
    return homePageRepository.getCurrentCity();
  }

  Future<void> setCurrentCity() {
    return homePageRepository.setCity();
  }
}
