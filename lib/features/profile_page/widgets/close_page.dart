import 'package:flutter/material.dart';

class ClosePage extends StatelessWidget {
  const ClosePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: InkWell(
              splashColor: Colors.red,
              onTap: () {},
              borderRadius: BorderRadius.circular(20),
              child: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
