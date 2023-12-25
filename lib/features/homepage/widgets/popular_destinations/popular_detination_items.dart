// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:here/features/skeleton/controller/skeleton_repositoy_controller.dart';
import 'package:here/models/city_model.dart';

import '../../../../common_widget/loader.dart';
import 'popular_destination_item_widget.dart';

class PopularDestinationItems extends ConsumerWidget {
  const PopularDestinationItems({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CityModel? city = ref.watch(SkeletonControllerProvider).getCityDetails();
    if (city == null) return LoaderWidget();
    return SizedBox(
      height: size.height * 0.38,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        // itemCount: min(3),
        itemCount: 3,
        itemBuilder: (context, index) {
          return PopularDestinationItemWidget(
            size: size,
            // plc: city.places[index],
          );
        },
      ),
    );
  }
}
