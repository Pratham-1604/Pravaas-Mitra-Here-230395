// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class OptionsWidget extends StatelessWidget {
  const OptionsWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: double.infinity),
          Text(
            'Options',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Column(
            children: [
              OptionsItems(
                icon: Icons.home,
                s: 'Favourite Tours',
                onTap: () {},
                size: size,
                isTop: true,
                isBottom: false,
              ),
              OptionsItems(
                icon: Icons.person,
                s: 'Manage Your Profile',
                onTap: () {},
                size: size,
                isTop: false,
                isBottom: false,
              ),
              OptionsItems(
                icon: Icons.settings,
                s: 'Other settings',
                onTap: () {},
                size: size,
                isTop: false,
                isBottom: false,
              ),
              OptionsItems(
                icon: Icons.support_agent,
                s: 'Help and Support',
                onTap: () {},
                size: size,
                isTop: false,
                isBottom: false,
              ),
              OptionsItems(
                icon: Icons.logout_rounded,
                s: 'Logout',
                onTap: () {},
                size: size,
                isTop: false,
                isBottom: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OptionsItems extends StatelessWidget {
  const OptionsItems({
    Key? key,
    required this.icon,
    required this.s,
    required this.onTap,
    required this.size,
    required this.isTop,
    required this.isBottom,
  }) : super(key: key);

  final IconData icon;
  final String s;
  final VoidCallback onTap;
  final Size size;
  final bool isTop;
  final bool isBottom;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.blue,
      child: Ink(
        height: 60,
        width: size.width * 0.888,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: isTop
              ? BorderRadius.vertical(
                  top: Radius.circular(20),
                )
              : isBottom
                  ? BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    )
                  : null,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            children: [
              Icon(icon),
              SizedBox(width: 10),
              Text(
                s,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
