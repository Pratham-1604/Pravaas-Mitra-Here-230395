// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:here/models/city_model.dart';
import 'package:here_sdk/core.dart';

import '../repository/skeleton_repository_provider.dart';

final SkeletonControllerProvider = Provider((ref) {
  final skeletonRepository = ref.watch(SkeletonRepositoryProvider);
  return SkeletonController(skeletonRepository, ref);
});

class SkeletonController {
  final SkeletonRepository skeletonRepository;
  final ProviderRef ref;

  SkeletonController(
    this.skeletonRepository,
    this.ref,
  );

  CityModel? getCityDetails() {
    debugPrint("get current city contoller");
    return skeletonRepository.getCurrentCity();
  }

  Future<void> setCurrentCity(BuildContext context) {
    debugPrint("set current city contoller");
    return skeletonRepository.setCity(context);
  }

  Future<GeoCoordinates> getCurrentPosition(BuildContext context) {
    return skeletonRepository.determinePosition(context);
  }
}
