import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.size,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  final Size size;
  final int currentIndex;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.075,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => onTap(0),
            icon: Icon(
              Icons.house,
              size: 30,
              color: currentIndex == 0 ? Colors.blue : Colors.grey,
            ),
          ),
          const SizedBox(width: 20),
          IconButton(
            onPressed: () => onTap(1),
            icon: Icon(
              Icons.favorite_border_sharp,
              size: 30,
              color: currentIndex == 1 ? Colors.blue : Colors.grey,
            ),
          ),
          const SizedBox(width: 20),
          IconButton(
            onPressed: () => onTap(2),
            icon: Icon(
              Icons.person_2_outlined,
              size: 30,
              color: currentIndex == 2 ? Colors.blue : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
