import 'package:flutter/material.dart';
import 'package:heatmap_app/screens/ranking_screen.dart';
import 'package:heatmap_app/visuals/colors.dart';
import 'package:heatmap_app/visuals/visual_constants.dart';

class RankingButton extends StatelessWidget {
  final String number;

  const RankingButton({
    required this.number,
  });

  final double radius = homeScreenButtonRadius + homeScreenButtonBorder;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add your onTap functionality here
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RankingScreen()),
        );
      },
      child: Container(
        width: radius * 2, // Diameter of the circle
        height: radius * 2, // Diameter of the circle
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: mainAccent, // Circle color
        ),
        child: Center(
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white, // Text color
              fontSize: 24.0, // Font size
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
