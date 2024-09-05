import 'package:flutter/material.dart';
import 'package:heatmap_app/components/ranking_screen/first_place_holder.dart';
import 'package:heatmap_app/components/ranking_screen/standard_ranking.dart';
import 'package:heatmap_app/visuals/colors.dart';
import 'package:heatmap_app/visuals/text_styles.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPrimary,
      appBar: AppBar(
        backgroundColor: backgroundPrimary,
        foregroundColor: Colors.white,
        title: const Text(
          'Rankings',
          style: actionItem,
        ),
      ),
      body: ListView(
        children: [
          const FirstPlaceHolder(),
          StandardRanking(index: 2),
          StandardRanking(index: 3),
          StandardRanking(index: 4),
        ],
      ),
    );
  }
}
