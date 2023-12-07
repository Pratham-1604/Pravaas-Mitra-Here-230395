// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

import 'widgets/app_bar_widget.dart';
import 'widgets/popular_destinations/popular_destinations_widget.dart';
import 'widgets/recommend/recommend_tour_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width,
              height: size.width * 0.04,
            ),
            AppBarWidget(),
            const SizedBox(height: 20),
            PopularDestinationWidget(size: size),
            const SizedBox(height: 20),
            RecommendTourWidget(size: size),
            // bottom nav bar pending
          ],
        ),
      ),
    );
  }
}
