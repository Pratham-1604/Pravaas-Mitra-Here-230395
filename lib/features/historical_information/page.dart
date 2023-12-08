// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:here/features/historical_information/widgets/map_page.dart';

import 'package:here/features/historical_information/widgets/read_more.dart';
import 'package:here/models/places_model.dart';

import 'widgets/image_widget.dart';

class HistoricalInformationPage extends StatelessWidget {
  const HistoricalInformationPage({
    Key? key,
    required this.plc,
  }) : super(key: key);

  final PlacesModel plc;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: size.width,
                height: size.height * 0.01,
              ),
              ImageWidget(size: size, img: plc.images),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                child: Column(
                  children: [
                    NameAndMap(name: plc.name),
                    const SizedBox(height: 4),
                    ReviewsWidget(
                      rating: plc.ratings,
                    ),
                    const SizedBox(height: 10),
                    ReadMoreTextWidget(
                      text: plc.info,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ReviewsWidget extends StatelessWidget {
  const ReviewsWidget({
    Key? key,
    required this.rating,
  }) : super(key: key);

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: Colors.yellow,
          size: 20,
        ),
        const SizedBox(width: 2),
        Text(
          rating.toString(),
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          ' (365 Reviews)',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class NameAndMap extends StatelessWidget {
  const NameAndMap({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MapPage(),
              ),
            );
          },
          child: Text(
            'Show map',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
