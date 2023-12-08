import 'package:flutter/material.dart';

import 'recommend_tour_items_widget.dart';

class RecommendTourItems extends StatelessWidget {
  const RecommendTourItems({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (context, index) {
          return RecommendedTourItemWidget(size: size);
        },
      ),
    );
  }
}
