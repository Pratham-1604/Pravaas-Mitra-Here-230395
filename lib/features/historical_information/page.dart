// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

import 'package:here/features/historical_information/widgets/read_more.dart';
import 'package:here/models/places_model.dart';

import 'widgets/image_widget.dart';
import 'widgets/name_and_map.dart';
import 'widgets/reviews_widget.dart';

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
                    NameAndMap(
                      name: plc.name,
                      lati: plc.latitude,
                      longi: plc.longitude,
                    ),
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
