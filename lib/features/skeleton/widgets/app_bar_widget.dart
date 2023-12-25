// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    Key? key,
    required this.cityName,
    required this.countryName,
    required this.onFindCityPressed,
  }) : super(key: key);

  final String cityName;
  final String countryName;
  final VoidCallback onFindCityPressed;

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
                  Text('$cityName $countryName'),
                  PopupMenuButton(
                    initialValue: 'current', // Set the initial value
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem(
                          child: Text("$cityName $countryName"),
                          value: 'current',
                        ),
                        PopupMenuItem(
                          child: Text('Find Another City'),
                          value: 'findCity',
                        ),
                      ];
                    },
                    onSelected: (value) {
                      if (value == 'findCity') {
                        onFindCityPressed();
                      }
                    },
                    child: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Colors.blue,
                    ),
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
