// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:here/features/historical%20information/widgets/read_more.dart';

import 'widgets/image_widget.dart';

class HistoricalInformationPage extends StatelessWidget {
  const HistoricalInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    String eg =
        'The sun dipped below the horizon, casting a warm orange glow across the tranquil sea. The waves gently lapped against the shore, creating a soothing melody that echoed through the quiet coastal town. Seagulls soared in the sky, their cries mingling with the distant laughter of children playing on the sandy beach. As twilight settled in, the first stars began to twinkle overhead, painting the night sky with a celestial brilliance. A gentle breeze rustled through the palm trees, carrying with it the scent of saltwater and blooming flowers. In the distance, a lighthouse stood tall, its beacon guiding ships safely through the dark waters. The air was filled with a sense of serenity, as if time itself had slowed down to savor the beauty of the moment. Shadows danced along the cobblestone streets as the town gradually embraced the calm of the evening. It was a scene of pure tranquility, where nature and human presence harmonized in a timeless dance.';
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
              ImageWidget(size: size),
              const SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                child: Column(
                  children: [
                    NameAndMap(),
                    const SizedBox(height: 4),
                    ReviewsWidget(),
                    const SizedBox(height: 10),
                    ReadMoreTextWidget(
                      text: eg,
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
    super.key,
  });

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
          '4.5',
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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Name',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {},
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
