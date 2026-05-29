import 'package:flutter/material.dart';
import 'dart:async';
import '../components/app_colors.dart';
import '../components/button.dart';
import '../components/user_header.dart';
import '../components/clock_display.dart';
import '../components/info_card.dart';
import '../components/bottom_nav_bar.dart';
import '../components/close_point_modal.dart';
import 'history_page.dart';

class HomescreenPage extends StatefulWidget {
  const HomescreenPage({super.key});

  @override
  State<HomescreenPage> createState() => _HomescreenPageState();
}

class _HomescreenPageState extends State<HomescreenPage> {
  bool _isAdvancedState = false;
  int _navIndex = 0;

  late String _dataAtual;
  late String _tempoAtual;
  late Timer _timer;

  late DateTime? _punchStartTime;
  late Duration _elapsedTime;

  static const List<String> _diasSemana = [
    'Domingo',
    'Segunda-feira',
    'Terça-feira',
    'Quarta-feira',
    'Quinta-feira',
    'Sexta-feira',
    'Sábado'
  ];

  static const List<String> _meses = [
    'janeiro',
    'fevereiro',
    'março',
    'abril',
    'maio',
    'junho',
    'julho',
    'agosto',
    'setembro',
    'outubro',
    'novembro',
    'dezembro'
  ];

  /// Formata a duração decorrida no formato para o modal (HH:MM:SS)
  String get _formattedElapsedTime {
    final hours = _elapsedTime.inHours.toString().padLeft(2, '0');
    final minutes =
        (_elapsedTime.inMinutes % 60).toString().padLeft(2, '0');
    final seconds =
        (_elapsedTime.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  /// Formata a duração decorrida no formato para o card (HH:MM)
  String get _formattedElapsedTimeHM {
    final hours = _elapsedTime.inHours.toString().padLeft(2, '0');
    final minutes =
        (_elapsedTime.inMinutes % 60).toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  void _handlePunchAction() {
    if (_isAdvancedState) {
      if (_punchStartTime != null) {
        _elapsedTime =
            DateTime.now().difference(_punchStartTime!);
      }

      ClosePointModal.show(
        context,
        totalHours: _formattedElapsedTime,
        onConfirm: () {
          setState(() {
            _isAdvancedState = false;
            _punchStartTime = null;
            _elapsedTime = Duration.zero;
          });
        },
      );
    } else {
      setState(() {
        _isAdvancedState = true;
        _punchStartTime = DateTime.now();
        _elapsedTime = Duration.zero;
      });
    }
  }

  void _handleNavTap(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const HistoryPage()),
      );
    } else {
      setState(() => _navIndex = index);
    }
  }

  @override
  void initState() {
    super.initState();
    _punchStartTime = null;
    _elapsedTime = Duration.zero;

    _atualizarDataHora();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _atualizarDataHora(),
    );
  }

  void _atualizarDataHora() {
    final agora = DateTime.now();
    final diaSemana = _diasSemana[agora.weekday % 7];
    final mesExtenso = _meses[agora.month - 1];

    if (_isAdvancedState && _punchStartTime != null) {
      _elapsedTime = agora.difference(_punchStartTime!);
    }

    setState(() {
      _tempoAtual =
          '${agora.hour.toString().padLeft(2, '0')}:${agora.minute.toString().padLeft(2, '0')}:${agora.second.toString().padLeft(2, '0')}';
      _dataAtual =
          '$diaSemana, ${agora.day} de $mesExtenso de ${agora.year}';
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const UserHeader(name: 'Usuário', role: 'Função'),
                    const SizedBox(height: 36),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: ClockDisplay(
                        key: ValueKey(_isAdvancedState),
                        date: _dataAtual,
                        time: _tempoAtual,
                      ),
                    ),
                    const SizedBox(height: 40),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Button(
                        key: ValueKey(_isAdvancedState),
                        text: _isAdvancedState ? 'Fechar ponto' : 'Bater ponto',
                        isSecondary: _isAdvancedState,
                        onPressed: _handlePunchAction,
                      ),
                    ),
                    const SizedBox(height: 32),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      transitionBuilder: (child, animation) =>
                          FadeTransition(opacity: animation, child: child),
                      child: _isAdvancedState
                          ? _AdvancedCards(
                              key: const ValueKey('advanced'),
                              elapsedTime: _formattedElapsedTimeHM,
                            )
                          : _InitialCards(key: const ValueKey('initial')),
                    ),
                  ],
                ),
              ),
            ),
            BottomNavBar(currentIndex: _navIndex, onTap: _handleNavTap),
          ],
        ),
      ),
    );
  }
}

class _InitialCards extends StatelessWidget {
  const _InitialCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoCard(
          title: 'Último registro',
          subtitle: 'Entrada às 08:30',
          status: CardStatus.done,
        ),
        InfoCard(
          title: 'Total de horas',
          subtitle: '02h 15m',
          status: CardStatus.done,
        ),
      ],
    );
  }
}

class _AdvancedCards extends StatelessWidget {
  final String elapsedTime;

  const _AdvancedCards({
    required this.elapsedTime,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoCard(
          title: 'Horas registradas',
          subtitle: elapsedTime,
          status: CardStatus.inProgress,
        ),
        InfoCard(
          title: 'Último registro',
          subtitle: 'Entrada às 08:30',
          status: CardStatus.done,
        ),
        InfoCard(
          title: 'Total de horas',
          subtitle: '02h 15m',
          status: CardStatus.done,
        ),
      ],
    );
  }
}
