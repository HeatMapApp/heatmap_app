import 'package:flutter/material.dart';
import 'package:heatmap_app/visuals/colors.dart';

class CircleRankAvatar extends StatelessWidget {
  final String imageUrl;

  const CircleRankAvatar({required this.imageUrl});

  final double radius = 20;
  final double borderWidth = 2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add your onTap functionality here
        // Open profile page here... Navigator.push()
      },
      child: Container(
        padding: EdgeInsets.all(borderWidth), // Border width
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: mainAccent, // Border color
            width: borderWidth, // Border width
          ),
        ),
        child: CircleAvatar(
          radius: radius, // Adjust the radius as needed
          backgroundColor: Colors.transparent,
          child: ClipOval(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: 2 * radius, // Image width (2 * radius)
              height: 2 * radius, // Image height (2 * radius)
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/th.jpg', // Path to your fallback asset image
                  fit: BoxFit.cover,
                  width: 2 * radius,
                  height: 2 * radius,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
