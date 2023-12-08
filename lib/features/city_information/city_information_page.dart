import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:here/features/home_page/controller/home_page_repositoy_controller.dart';
import 'package:here/models/city_model.dart';

import 'widgets/filters/filter_widget.dart';
import 'widgets/popular_destinations/popular_destinations_widget.dart';
import 'widgets/recommend/recommend_tour_widget.dart';

class CityInformationMainPage extends ConsumerWidget {
  const CityInformationMainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    CityModel city = ref.read(HomePageControllerProvider).getCityDetails();
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(height: 20),
            FiltersWidget(size: size),
            const SizedBox(height: 20),
            PopularDestinationWidget(size: size),
            const SizedBox(height: 20),
            RecommendTourWidget(size: size),
          ],
        ),
      ),
    );
  }
}
