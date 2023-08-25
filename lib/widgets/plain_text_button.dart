import 'package:flutter/material.dart';

class PlainTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  const PlainTextButton({super.key, this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero, // Remove padding to make it look like plain text
        alignment: Alignment.centerLeft, // Align text to the left
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.normal
        ),
      ),
    );
  }
}