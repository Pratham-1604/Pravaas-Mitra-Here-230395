// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(width: size.width),
            Row(
              children: [
                Text('Explore'),
                Row(
                  children: [
                    Icon(Icons.location_on),
                    Text('Aspen, USA'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
