import 'package:flutter/material.dart';
import 'dart:math';

import 'package:heatmap_app/visuals/colors.dart';

class CircleWithTicks extends StatelessWidget {
  CircleWithTicks({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(710, 710), // Define the size of the circle
      painter: CircleWithTicksPainter(),
    );
  }
}

class CircleWithTicksPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);

    final circlePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    // Draw the circle
    canvas.drawCircle(center, radius, circlePaint);

    final bigTickPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3.0;

    final smallTickPaint = Paint()
      ..color = faintSubpoint
      ..strokeWidth = 3.0;

    // Define the number of big and small tick marks
    const bigTickCount = 20;
    const smallTickCount = 80;
    const totalTickCount = bigTickCount + smallTickCount;

    // Calculate angles between ticks
    const bigTickAngle = 2 * pi / bigTickCount;
    const smallTickAngle = 2 * pi / totalTickCount;

    // Draw big tick marks
    for (int i = 0; i < bigTickCount; i++) {
      final angle = i * bigTickAngle;
      _drawTickMark(canvas, center, radius, angle, bigTickPaint, 15.0);
    }

    // Draw small tick marks between big tick marks
    for (int i = 0; i < totalTickCount; i++) {
      if (i % 5 != 0) {
        // Skip the positions of the big tick marks
        final angle = i * smallTickAngle;
        _drawTickMark(canvas, center, radius, angle, smallTickPaint, 7.0);
      }
    }
  }

  void _drawTickMark(Canvas canvas, Offset center, double radius, double angle,
      Paint paint, double tickLength) {
    final x1 = center.dx + radius * cos(angle);
    final y1 = center.dy + radius * sin(angle);
    final x2 = center.dx + (radius - tickLength) * cos(angle);
    final y2 = center.dy + (radius - tickLength) * sin(angle);
    canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // No need to repaint if nothing changes
  }
}
