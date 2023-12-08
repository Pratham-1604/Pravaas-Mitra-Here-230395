// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:here/features/home_page/controller/home_page_repositoy_controller.dart';
import 'package:here/models/city_model.dart';

import 'popular_destination_item_widget.dart';

class PopularDestinationItems extends ConsumerWidget {
  const PopularDestinationItems({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CityModel city = ref.read(HomePageControllerProvider).getCityDetails();
    return SizedBox(
      height: size.height * 0.38,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: min(city.places.length, 3),
        itemBuilder: (context, index) {
          return PopularDestinationItemWidget(
            size: size,
            plc: city.places[index],
          );
        },
      ),
    );
  }
}
