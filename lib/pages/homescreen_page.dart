import 'package:flutter/material.dart';
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

  void _handlePunchAction() {
    if (_isAdvancedState) {
      // Está no estado avançado: abre modal antes de fechar o ponto
      ClosePointModal.show(
        context,
        totalHours: '07h 15m',
        onConfirm: () {
          // Modal confirmado: volta para o estado inicial
          setState(() => _isAdvancedState = false);
        },
      );
    } else {
      // Bater ponto: entra direto no estado avançado
      setState(() => _isAdvancedState = true);
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
                    const UserHeader(
                      name: 'Usuário',
                      role: 'Função',
                    ),
                    const SizedBox(height: 36),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: ClockDisplay(
                        key: ValueKey(_isAdvancedState),
                        date: 'Segunda-feira, 25 de maio de 2026',
                        time: _isAdvancedState ? '17:50:80' : '10:00:00',
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
                      transitionBuilder: (child, animation) => FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                      child: _isAdvancedState
                          ? _AdvancedCards(key: const ValueKey('advanced'))
                          : _InitialCards(key: const ValueKey('initial')),
                    ),
                  ],
                ),
              ),
            ),
            BottomNavBar(
              currentIndex: _navIndex,
              onTap: _handleNavTap,
            ),
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
  const _AdvancedCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoCard(
          title: 'Horas registradas',
          subtitle: '07h 30m',
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