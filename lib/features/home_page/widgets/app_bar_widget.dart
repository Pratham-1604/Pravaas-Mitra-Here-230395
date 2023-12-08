// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    Key? key,
    required this.cityName,
    required this.countryName,
  }) : super(key: key);

  final String cityName;
  final String countryName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Explore',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 2),
                  Text("$cityName $countryName"),
                  Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            cityName,
            style: TextStyle(fontSize: 40),
          ),
        ),
      ],
    );
  }
}
