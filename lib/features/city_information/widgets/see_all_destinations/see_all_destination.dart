// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:here/features/city_information/widgets/popular_destinations/popular_destination_item_widget.dart';

import './widgets//search_bar.dart';
import 'widgets/app_bar.dart';

class SeeAllDestinations extends StatelessWidget {
  const SeeAllDestinations({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            AppBarWidget(),
            const SizedBox(height: 20),
            SearchBar(),
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
                      child: PopularDestinationItemWidget(
                        size: size,
                      ),
                    ),
                    itemCount: 4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
