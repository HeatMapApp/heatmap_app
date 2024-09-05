import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math'; // Import for using pi

import 'package:heatmap_app/components/circle_with_ticks.dart';

class SpinningWheel extends StatefulWidget {
  final Function(double) onChange; // Callback that accepts the current rotation

  const SpinningWheel({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  @override
  _SpinningWheelState createState() => _SpinningWheelState();
}

class _SpinningWheelState extends State<SpinningWheel>
    with SingleTickerProviderStateMixin {
  double _rotation = 0.0;
  double _velocity = 0.0;
  Timer? _inertiaTimer;

  static const double maxRotation = pi; // +180 degrees in radians
  static const double minRotation = -pi; // -180 degrees in radians

  @override
  void dispose() {
    _inertiaTimer?.cancel();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    // Cancel any existing inertia effect when the user interacts
    _inertiaTimer?.cancel();

    // Calculate the angle change based on the drag update
    setState(() {
      _rotation += -details.delta.dy * 0.002; // Adjust sensitivity here
      _velocity = -details.delta.dy * 0.01; // Capture velocity

      // Constrain the rotation within -pi and pi
      if (_rotation > maxRotation) {
        _rotation = maxRotation;
        _velocity = 0.0; // Stop further movement in this direction
      } else if (_rotation < minRotation) {
        _rotation = minRotation;
        _velocity = 0.0; // Stop further movement in this direction
      }

      // Call onChange callback when rotation changes
      widget.onChange(_rotation);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    // Start inertia effect after user releases
    _inertiaTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        _rotation += _velocity;
        _velocity *= 0.85; // Reduce velocity over time to simulate inertia

        // Constrain the rotation within -pi and pi
        if (_rotation > maxRotation) {
          _rotation = maxRotation;
          _velocity = 0.0;
          timer.cancel(); // Stop the timer
        } else if (_rotation < minRotation) {
          _rotation = minRotation;
          _velocity = 0.0;
          timer.cancel(); // Stop the timer
        }

        // Call onChange callback when rotation changes
        widget.onChange(_rotation);

        if (_velocity.abs() < 0.01) {
          _velocity = 0.0;
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Transform.rotate(
        angle: _rotation,
        child: CircleWithTicks(),
      ),
    );
  }
}
