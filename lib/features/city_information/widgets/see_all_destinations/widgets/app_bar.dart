// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({
    Key? key,
    required this.cityname,
  }) : super(key: key);

  final String cityname;

  static const List<String> tags = [
    "Locations",
    "Hotels",
    "Food",
    "Adventure",
    "Parks",
  ];

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  List<bool> selectedTags = List.filled(AppBarWidget.tags.length, false);

  Widget _buildPopupMenu() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: PopupMenuButton<String>(
        icon: Icon(Icons.more_vert),
        itemBuilder: (BuildContext context) {
          return List.generate(AppBarWidget.tags.length, (index) {
            return PopupMenuItem<String>(
              value: AppBarWidget.tags[index],
              child: Row(
                children: [
                  Checkbox(
                    value: selectedTags[index],
                    onChanged: (bool? value) {
                      setState(() {
                        selectedTags[index] = value ?? false;
                      });
                    },
                  ),
                  Text(AppBarWidget.tags[index]),
                ],
              ),
            );
          });
        },
        onSelected: (String result) {
          // Handle the selected tag
          print('Selected Tag: $result');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.chevron_left_sharp,
                size: 24,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.cityname,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Container(
        //     decoration: BoxDecoration(
        //       color: Colors.white,
        //       shape: BoxShape.circle,
        //     ),
        //     child: IconButton(
        //       onPressed: () {},
        //       icon: Icon(Icons.more_vert_outlined),
        //     ),
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildPopupMenu(),
        ),
      ],
    );
  }
}
