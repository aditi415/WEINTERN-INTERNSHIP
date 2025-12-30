import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final String text;
  final Function(String) onTap;

  const CalcButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onTap(text),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(70, 50),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
