// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:here/features/skeleton/controller/skeleton_repositoy_controller.dart';
import '../see_all_destinations/see_all_destination.dart';

import 'popular_detination_items.dart';

class PopularDestinationWidget extends ConsumerWidget {
  const PopularDestinationWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Popular',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  ref.read(SkeletonControllerProvider).getCategories(context);
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => SeeAllDestinations(),
                  //   ),
                  // );
                },
                child: Text('See All'),
              ),
            ],
          ),
        ),
        PopularDestinationItems(size: size),
      ],
    );
  }
}
