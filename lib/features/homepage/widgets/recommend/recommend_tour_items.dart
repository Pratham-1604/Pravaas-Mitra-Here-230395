import 'package:flutter/material.dart';

import 'recommend_tour_items_widget.dart';

class RecommendTourItems extends StatelessWidget {
  const RecommendTourItems({
    super.key,
    required this.size,
  });

  final Size size;

  static const List a = [
    {
      "name": "Adventurous Pune",
      "imgUrl":
          "https://images.herzindagi.info/image/2022/Oct/places-to-visit-in-pune.jpg",
      "time": "2N 3D",
    },
    {
      "name": "Luxurious Pune",
      "imgUrl":
          "https://t4.ftcdn.net/jpg/02/87/42/67/360_F_287426729_qbmatCI3Tc8XIQ5hjUJriYZOZlVUOnb4.jpg",
      "time": "3N 4D",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: a.length,
        itemBuilder: (context, index) {
          return RecommendedTourItemWidget(
            size: size,
            name: a[index]['name'],
            imgUrl: a[index]['imgUrl'],
            time: a[index]['time'],
          );
        },
      ),
    );
  }
}
