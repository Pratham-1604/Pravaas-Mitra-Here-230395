import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({
    Key? key,
    required this.size,
    required this.s,
    required this.icon,
  }) : super(key: key);

  final Size size;
  final String s;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.15,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                // Icons.notifications_none_rounded,
                icon,
                // color: Colors.white,
                size: 30,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            s,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
