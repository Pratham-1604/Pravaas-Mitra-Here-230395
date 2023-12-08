import 'package:flutter/material.dart';

import 'widgets/filters/filter_widget.dart';
import 'widgets/popular_destinations/popular_destinations_widget.dart';
import 'widgets/recommend/recommend_tour_widget.dart';

class CityInformationMainPage extends StatelessWidget {
  const CityInformationMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
  