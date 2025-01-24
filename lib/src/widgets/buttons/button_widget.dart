import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {

  VoidCallback onPressed;
  String text;
  Color? backgroundColor;
  Size? size;

  ButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: backgroundColor,
        fixedSize: size,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10)
      ),
      onPressed: onPressed,
      child: Text(text, style: const TextStyle(fontSize: 16),)
    );
  }
}


