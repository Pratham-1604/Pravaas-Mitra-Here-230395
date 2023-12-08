// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key? key,
    required this.size,
    required this.img,
  }) : super(key: key);

  final Size size;
  final String img;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.95,
      height: size.height * 0.4,
      child: Stack(
        children: [
          Positioned(
            // height: size.height * 0.3,
            child: Container(
              height: size.height * 0.38,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // color: Colors.black,
              ),
              child: Image.network(
                img,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 10,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.chevron_left_outlined,
                    size: 20,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: -2,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.red,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
