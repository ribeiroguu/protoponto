import 'package:flutter/material.dart';
import 'app_colors.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isSecondary;
  final double? width;

  const Button({
    super.key,
    required this.text,
    this.onPressed,
    this.isSecondary = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isSecondary 
        ? AppColors.warning // Cor secundária
        : AppColors.secondary; // Cor default

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        fixedSize: Size(width ?? 350, 56),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white, 
          fontFamily: 'Inter',
          fontSize: 18,
        ),
      ),
    );
  }
}