import 'package:flutter/material.dart';

class FormLabel extends StatelessWidget {
  final String label;
  final double size;
  final Color color;
  const FormLabel({required this.label, this.size = 12, this.color = Colors.white54});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: TextAlign.end,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: color,
        fontSize: size,
      ),
    );
  }
}
