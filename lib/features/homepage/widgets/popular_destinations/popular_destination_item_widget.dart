// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

import 'package:here/features/historical_information/detailed_historical_information_page.dart';
import 'package:here/models/places_model.dart';

class PopularDestinationItemWidget extends StatelessWidget {
  const PopularDestinationItemWidget({
    Key? key,
    required this.size,
    // required this.plc,
  }) : super(key: key);

  final Size size;
  // final PlacesModel plc;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => DetailedHistoricalInformationPage(),
        //   ),
        // );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Container(
              height: size.height * 0.35,
              width: size.width * 0.55,
              decoration: BoxDecoration(
                // color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
              // child: Image.network(
              //   // plc.images,
              //   fit: BoxFit.cover,
              // ),
            ),
            Positioned(
              bottom: size.height * 0.35 * 0.2,
              left: 11,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    "Hi",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: size.height * 0.35 * 0.08,
              left: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "4.5",
                        // plc.ratings.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 2),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: size.height * 0.35 * 0.08,
              right: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
