import 'package:flutter/material.dart';
import 'package:heatmap_app/visuals/colors.dart';
import 'package:heatmap_app/visuals/text_styles.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final Icon? icon;
  final void Function()? onTap;

  const ActionButton({super.key, required this.text, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            50.0), // High border radius for rounded corners
      ),
      onPressed: onTap,
      color: mainAccent,
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            if (icon != null) ...[
              icon!, // Display the icon only if it is not null
              const SizedBox(width: 5),
            ],
            Text(
              text,
              style: actionItem,
            ),
          ]),
        ),
      ),
    );
  }
}
