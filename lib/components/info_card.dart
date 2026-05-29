import 'package:flutter/material.dart';
import 'app_colors.dart';

enum CardStatus { done, inProgress }

class InfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final CardStatus status;

  const InfoCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.status = CardStatus.done,
  });

  @override
  Widget build(BuildContext context) {
    final isInProgress = status == CardStatus.inProgress;

    final tagColor = isInProgress
        ? const Color(0xFFFFF3CD)
        : const Color(0xFFD4EDDA);

    final tagTextColor = isInProgress
        ? const Color(0xFF856404)
        : const Color(0xFF155724);

    final tagLabel = isInProgress ? 'Andamento' : 'Concluído';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Ícone
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.access_time_rounded,
              color: AppColors.secondary,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          // Textos
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          // Tag de status
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: tagColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              tagLabel,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: tagTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}