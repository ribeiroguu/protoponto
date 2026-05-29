import 'package:flutter/material.dart';
import 'app_colors.dart';

class ClockDisplay extends StatelessWidget {
  final String time;        // ex: "10:00:00"
  final String date;        // ex: "Segunda-feira, 25 de maio de 2026"

  const ClockDisplay({
    super.key,
    required this.time,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          date,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          time,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 52,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}