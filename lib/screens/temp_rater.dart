import 'dart:math';

import 'package:flutter/material.dart';
import 'package:heatmap_app/components/action_button.dart';
import 'package:heatmap_app/components/spinning_widget.dart';
import 'package:heatmap_app/visuals/colors.dart';
import 'package:heatmap_app/visuals/text_styles.dart';

// I WANT TO MAKE IT SUCH THAT AS THE TEMP NEARS 100, THE TOP OF THE SCREEN
// GETS A RED TINT, AND AS IT NEARS 0, THE BOTTOM GETS A BLUE TINT.

class TempRater extends StatefulWidget {
  const TempRater({super.key});

  @override
  State<TempRater> createState() => _TempRaterState();
}

class _TempRaterState extends State<TempRater> {
  int _temp = 50;
  final int minTemp = 0;
  final int maxTemp = 100;

  void _setTemp(double rotation) {
    final double tempDouble = (rotation * -50 / pi) + 50;

    if (tempDouble >= minTemp && tempDouble <= maxTemp) {
      setState(() {
        _temp = tempDouble.round();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPrimary,
      body: Stack(
        children: [
          Positioned(
            right: -560, // Adjust this value based on your widget's size
            top: MediaQuery.of(context).size.height / 2 -
                700 / 2, // Vertically centered (400/2 = 200)
            child: SpinningWheel(
              onChange: _setTemp,
            ),
          ),
          Center(
            child: Text(
              '$_temp°',
              style: centralBold,
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: ActionButton(
                  text: 'Confirm Rating',
                  icon: const Icon(Icons.thermostat, color: Colors.white),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
