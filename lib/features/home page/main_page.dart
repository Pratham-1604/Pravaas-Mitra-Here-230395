import 'package:flutter/material.dart';

import 'widgets/app_bar_widget.dart';
import 'widgets/filters/filter_widget.dart';
import 'widgets/popular_destinations/popular_destinations_widget.dart';
import 'widgets/recommend/recommend_tour_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width,
              height: size.width * 0.04,
            ),
            const AppBarWidget(),
            Expanded(
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
            ),
            BottomNavBar(size: size),
          ],
        ),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.075,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer, // Add this line
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.house,
              size: 30,
              color: Colors.blue,
            ),
          ),
          const SizedBox(width: 20),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_border_sharp,
              size: 30,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 20),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.person_2_outlined,
              size: 30,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
