import 'package:flutter/material.dart';

import 'recommend_tour_items.dart';

class RecommendTourWidget extends StatelessWidget {
  const RecommendTourWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          child: Text(
            'Recommended',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        RecommendTourItems(size: size),
      ],
    );
  }
}
