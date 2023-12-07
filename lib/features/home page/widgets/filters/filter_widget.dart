// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

import 'filters_widget_item.dart';

class FiltersWidget extends StatefulWidget {
  const FiltersWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<FiltersWidget> createState() => _FiltersWidgetState();
}

class _FiltersWidgetState extends State<FiltersWidget> {
  static const List<String> tags = [
    "Locations",
    "Hotels",
    "Food",
    "Adventure",
    "Parks",
  ];

  int currInd = 0;

  void onTap(int ind) {
    setState(() {
      currInd = ind;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size.height * 0.05,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => FiltersWidgetItem(
          text: tags[index],
          isSelected: index == currInd,
          onTap: () => onTap(index),
        ),
        itemCount: tags.length,
      ),
    );
  }
}
