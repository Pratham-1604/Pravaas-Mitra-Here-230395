// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';


class ReviewsWidget extends StatelessWidget {
  const ReviewsWidget({
    Key? key,
    required this.rating,
  }) : super(key: key);

  final num rating;

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