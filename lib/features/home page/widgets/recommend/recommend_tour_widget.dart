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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
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
      ),
    );
  }
}
