import 'package:flutter/material.dart';
import '../components/app_colors.dart';
import '../components/user_header.dart';
import '../components/bottom_nav_bar.dart';
import '../components/history_card.dart';

// Modelo de dado para um registro de ponto
class _PunchRecord {
  final String timeRange;
  final String total;

  const _PunchRecord({required this.timeRange, required this.total});
}

// Modelo de dado para um grupo de registros por data
class _DayGroup {
  final String label;
  final List<_PunchRecord> records;

  const _DayGroup({required this.label, required this.records});
}

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int _navIndex = 1; // Histórico selecionado por padrão

  // Dados simulados — substitua por dados reais futuramente
  final List<_DayGroup> _history = const [
    _DayGroup(
      label: 'Segunda-feira, 25 de maio de 2026',
      records: [
        _PunchRecord(timeRange: '10:00 - 17:50', total: '07h 50m'),
        _PunchRecord(timeRange: '07:00 - 09:15', total: '02h 15m'),
      ],
    ),
    _DayGroup(
      label: 'Sexta-feira, 22 de maio de 2026',
      records: [
        _PunchRecord(timeRange: '14:30 - 17:50', total: '03h 20m'),
        _PunchRecord(timeRange: '10:00 - 12:15', total: '02h 15m'),
        _PunchRecord(timeRange: '07:00 - 09:15', total: '02h 15m'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  // Padding geral do conteúdo
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 24,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        // Cabeçalho de usuário
                        const UserHeader(
                          name: 'Usuário',
                          role: 'Função',
                        ),

                        const SizedBox(height: 28),

                        // Métrica semanal
                        _WeeklySummary(totalHours: '10h 05m'),

                        const SizedBox(height: 28),

                        // Grupos de registros
                        ..._history.map(
                          (group) => _DaySection(group: group),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),

            // Barra de navegação
            BottomNavBar(
              currentIndex: _navIndex,
              onTap: (index) {
                if (index == 0) {
                  Navigator.of(context).pop();
                } else {
                  setState(() => _navIndex = index);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Widget do resumo semanal
class _WeeklySummary extends StatelessWidget {
  final String totalHours;

  const _WeeklySummary({required this.totalHours});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Total de horas semanais',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            totalHours,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 44,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}

// Widget de seção de dia com label + cards
class _DaySection extends StatelessWidget {
  final _DayGroup group;

  const _DaySection({required this.group});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label da data
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            group.label,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
              letterSpacing: 0.3,
            ),
          ),
        ),

        // Cards de registro
        ...group.records.map(
          (record) => HistoryCard(
            timeRange: record.timeRange,
            total: record.total,
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}