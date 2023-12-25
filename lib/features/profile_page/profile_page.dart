import 'package:flutter/material.dart';

import '../homepage/widgets/see_all_destinations/widgets/search_bar.dart';

import 'widgets/close_page.dart';
import 'widgets/icon_widget.dart';
import 'widgets/options_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(width: double.infinity),
            SizedBox(height: size.height * 0.01),
            const ClosePage(),
            const SizedBox(height: 20),
            TextWidget(size: size),
            const SizedBox(height: 20),
            const SearchBarWidget(),
            const SizedBox(height: 20),
            IconsContainer(size: size),
            const SizedBox(height: 40),
            OptionsWidget(size: size)
          ],
        ),
      ),
    );
  }
}

class IconsContainer extends StatelessWidget {
  const IconsContainer({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(width: 30),
        IconWidget(
          size: size,
          icon: Icons.notifications_none_outlined,
          s: 'Notification',
        ),
        const SizedBox(width: 10),
        IconWidget(
          size: size,
          icon: Icons.location_city,
          s: 'Current City',
        ),
        const SizedBox(width: 10),
        IconWidget(
          size: size,
          icon: Icons.tour,
          s: 'Upcoming Tours',
        ),
        const SizedBox(width: 10),
        IconWidget(
          size: size,
          icon: Icons.wallet_giftcard_sharp,
          s: 'Previous Tour',
        ),
        const SizedBox(width: 30),
      ],
    );
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: size.width * 0.5,
          child: const Text(
            'Explore all the option in the app',
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
