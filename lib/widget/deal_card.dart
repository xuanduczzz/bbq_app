
import 'package:flutter/material.dart';
class DealCard extends StatelessWidget {
  final String title;
  final String description;
  final Color color;
  const DealCard({required this.title, required this.description, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text(description, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}