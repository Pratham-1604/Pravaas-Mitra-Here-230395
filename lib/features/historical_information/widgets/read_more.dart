import 'package:flutter/material.dart';

class ReadMoreTextWidget extends StatefulWidget {
  final String text;

  const ReadMoreTextWidget({super.key, required this.text});

  @override
  _ReadMoreTextWidgetState createState() => _ReadMoreTextWidgetState();
}

class _ReadMoreTextWidgetState extends State<ReadMoreTextWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    List<String> words = widget.text.split(' ');
    String displayText = isExpanded ? widget.text : words.take(30).join(' ');

    if (!isExpanded && words.length > 30) {
      displayText += '...';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          displayText,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        if (words.length > 50)
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    isExpanded ? 'Read Less' : 'Read More',
                    style: const TextStyle(color: Colors.blue),
                  ),
                  Icon(
                    isExpanded ? Icons.arrow_upward : Icons.arrow_downward,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
