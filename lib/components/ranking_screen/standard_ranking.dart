import 'package:flutter/material.dart';
import 'package:heatmap_app/components/ranking_screen/circle_rank_avatar.dart';
import 'package:heatmap_app/visuals/text_styles.dart';

class StandardRanking extends StatelessWidget {
  final int index;

  StandardRanking({super.key, required this.index});

  String rankSuffix = 'th';

  @override
  Widget build(BuildContext context) {
    final String indexStr = index.toString();
    final String finalLetter = indexStr[indexStr.length - 1];

    if (finalLetter == '1') {
      rankSuffix = 'st';
    } else if (finalLetter == '2') {
      rankSuffix = 'nd';
    } else if (finalLetter == '3') {
      rankSuffix = 'rd';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 0,
      ),
      child: Column(
        // FINISH THIS -- standard menu entry in rankings list
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleRankAvatar(
                imageUrl:
                    'https://upload.wikimedia.org/wikipedia/commons/6/63/Mayflower_Compact_Bradford.jpg',
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'benfdup',
                  overflow: TextOverflow.ellipsis,
                  style: subBold,
                ),
              ),
              // Spacer(),
              Text(
                '101,274 pts · $index$rankSuffix',
                style: subBold,
              ),
            ],
          ),
          const Divider(
            color: Color.fromARGB(59, 255, 255, 255),
          ),
        ],
      ),
    );
  }
}
