import 'package:flutter/material.dart';
import 'package:heatmap_app/visuals/colors.dart';
import 'package:heatmap_app/visuals/text_styles.dart';

class FirstPlaceHolder extends StatelessWidget {
  const FirstPlaceHolder({super.key});

  final double radius = 50;
  final double borderWidth = 2;
  final String imageUrl =
      'https://upload.wikimedia.org/wikipedia/commons/6/63/Mayflower_Compact_Bradford.jpg';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
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
        const SizedBox(height: 10),
        const Text(
          'benfdup',
          style: subBold,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 1),
        const Text(
          '1,000,000 pts · 1st',
          style: subBold,
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}
