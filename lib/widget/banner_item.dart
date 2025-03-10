import 'package:flutter/material.dart';
class BannerItem extends StatelessWidget {
  final String image;
  const BannerItem({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(image, fit: BoxFit.cover),
    );
  }
}
