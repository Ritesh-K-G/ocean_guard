import 'package:flutter/material.dart';
import 'package:ocean_guard/utils/helpers/AppHelpers.dart';

class DescriptionCard extends StatefulWidget {
  final String title;
  final String initialDescription;

  const DescriptionCard({super.key, required this.title, required this.initialDescription});

  @override
  _DescriptionCardState createState() => _DescriptionCardState();
}

class _DescriptionCardState extends State<DescriptionCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppHelpers.screenWidth(context)*0.95,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontFamily: 'Hind',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Text(
              isExpanded ? widget.initialDescription : _getDisplayText(),
              style: const TextStyle(
                fontFamily: 'Hind',
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
          if (widget.initialDescription.length > 150 && !isExpanded)
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = true;
                });
              },
              child: const Text(
                '...Read More',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _getDisplayText() {
    if (widget.initialDescription.length > 150) {
      return '${widget.initialDescription.substring(0, 150)}...';
    } else {
      return widget.initialDescription;
    }
  }
}
