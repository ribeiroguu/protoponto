import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'button.dart';
import '../models/punch_record.dart';

class ClosePointModal extends StatefulWidget {
  final String totalHours;
  final Function(PunchRecord) onConfirm;

  const ClosePointModal({
    super.key,
    required this.totalHours,
    required this.onConfirm,
  });

  static Future<bool?> show(
    BuildContext context, {
    required String totalHours,
    required Function(PunchRecord) onConfirm,
  }) {
    return showGeneralDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Fechar',
      barrierColor: Colors.black.withOpacity(0.55),
      transitionDuration: const Duration(milliseconds: 280),
      transitionBuilder: (ctx, anim, _, child) {
        final curved = CurvedAnimation(
          parent: anim,
          curve: Curves.easeOutCubic,
        );
        return ScaleTransition(
          scale: Tween<double>(begin: 0.92, end: 1.0).animate(curved),
          child: FadeTransition(opacity: curved, child: child),
        );
      },
      pageBuilder: (ctx, _, __) => ClosePointModal(
        totalHours: totalHours,
        onConfirm: onConfirm,
      ),
    );
  }

  @override
  State<ClosePointModal> createState() => _ClosePointModalState();
}

class _ClosePointModalState extends State<ClosePointModal> {
  final _projectController = TextEditingController();
  final _developedController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _projectController.dispose();
    _developedController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_projectController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha o campo Projeto.')),
      );
      return;
    }

    final punchRecord = PunchRecord(
      project: _projectController.text.trim(),
      developed: _developedController.text.trim(),
      description: _descriptionController.text.trim(),
      totalHours: widget.totalHours,
      timestamp: DateTime.now(),
    );

    Navigator.of(context).pop(true);
    widget.onConfirm(punchRecord);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.18),
                blurRadius: 32,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Total: ${widget.totalHours}',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(height: 8),

                _ModalField(
                  label: 'Projeto',
                  controller: _projectController,
                  maxLines: 1,
                ),

                const SizedBox(height: 14),

                _ModalField(
                  label: 'O que você desenvolveu hoje?',
                  controller: _developedController,
                  maxLines: 1,
                ),

                const SizedBox(height: 14),

                _ModalField(
                  label: 'Descrição',
                  controller: _descriptionController,
                  maxLines: 4,
                ),

                const SizedBox(height: 28),

                Button(
                  text: 'Enviar',
                  onPressed: _handleSubmit,
                  width: 320,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ModalField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int maxLines;

  const _ModalField({
    required this.label,
    required this.controller,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            color: AppColors.primary,
          ),
          decoration: InputDecoration(
            hintText: 'Escreva aqui...',
            hintStyle: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              color: Colors.grey,
            ),
            filled: true,
            fillColor: const Color(0xFFF0F0F3),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.secondary,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}