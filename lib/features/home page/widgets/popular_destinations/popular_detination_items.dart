// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

import 'popular_destination_item_widget.dart';


class PopularDestinationItems extends StatelessWidget {
  const PopularDestinationItems({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.38,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (context, index) {
          return PopularDestinationItemWidget(size: size);
        },
      ),
    );
  }
}
