import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
  });

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
                children: const [
                  Icon(
                    Icons.location_on,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 2),
                  Text('Aspen, USA'),
                  Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Aspen',
            style: TextStyle(fontSize: 40),
          ),
        ),
      ],
    );
  }
}
