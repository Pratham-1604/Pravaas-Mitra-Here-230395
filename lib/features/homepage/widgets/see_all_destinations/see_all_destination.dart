// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:here/common_widget/loader.dart';
import 'package:here/features/homepage/widgets/popular_destinations/popular_destination_item_widget.dart';

import '../../../../models/city_model.dart';
import '../../../skeleton/controller/skeleton_repositoy_controller.dart';
import './widgets/search_bar.dart';
import './widgets/app_bar.dart';

class SeeAllDestinations extends ConsumerWidget {
  const SeeAllDestinations({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CityModel? city = ref.watch(HomePageControllerProvider).getCityDetails();

    final size = MediaQuery.of(context).size;
    if (city == null) return LoaderWidget();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            AppBarWidget(
              cityname: city!.name,
            ),
            const SizedBox(height: 20),
            SearchBarWidget(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 10,
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Center(
                      // child: PopularDestinationItemWidget(
                        // size: size,
                        // plc: city.places[index],
                      ),
                    ),
                    // itemCount: city.places.length,
                  ),
                ),
              ),
            // ),
          ],
        ),
      ),
    );
  }
}
