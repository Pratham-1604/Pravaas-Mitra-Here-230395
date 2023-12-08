// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

import 'map_page.dart';

class NameAndMap extends StatelessWidget {
  const NameAndMap({
    Key? key,
    required this.name,
    required this.lati,
    required this.longi,
  }) : super(key: key);

  final String name;
  final double lati;
  final double longi;

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
                builder: (context) => MapPage(lati: lati, longi: longi,),
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
