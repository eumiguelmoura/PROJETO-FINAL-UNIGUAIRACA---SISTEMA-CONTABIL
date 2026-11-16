import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../services/auth_service.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/next_brand_mark.dart';

class HomeScreen extends StatelessWidget {
  final AuthService auth;
  const HomeScreen({super.key, required this.auth});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            NextBrandMark(size: 35),
            SizedBox(width: 10),
            NextBrandName(fontSize: 20),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Sair',
            icon: const Icon(Icons.logout_outlined),
            onPressed: () async {
              await auth.logout();
              if (context.mounted) context.go(AppRoutes.login);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.navy, Color(0xFF2F45A2)],
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('SEU ESPAÇO DE TRABALHO', style: TextStyle(color: AppColors.mint, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 1.5)),
                  SizedBox(height: 12),
                  Text('Bem-vindo ao NextContábil.', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w800)),
                  SizedBox(height: 10),
                  Text('Organize suas notas e acompanhe as apurações em um só lugar.', style: TextStyle(color: Color(0xFFD1DDF5), height: 1.5)),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text('Seus módulos', style: TextStyle(color: AppColors.navy, fontSize: 23, fontWeight: FontWeight.w800)),
            const SizedBox(height: 14),
            _ModuleCard(
              title: 'Lançamento de notas',
              subtitle: 'Cadastrar, consultar, editar e excluir notas fiscais.',
              icon: Icons.note_add_outlined,
              accent: AppColors.primary,
              iconBackground: const Color(0xFFECEEFF),
              onTap: () => context.go(AppRoutes.invoices),
            ),
            const SizedBox(height: 12),
            _ModuleCard(
              title: 'Apuração de impostos',
              subtitle: 'Selecionar notas e consultar os impostos apurados.',
              icon: Icons.calculate_outlined,
              accent: const Color(0xFF0CA591),
              iconBackground: const Color(0xFFE3F8F4),
              onTap: () => context.go(AppRoutes.assessments),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  const _ModuleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.iconBackground,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final Color iconBackground;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xFFE3E9F2)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(19),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(color: iconBackground, borderRadius: BorderRadius.circular(14)),
                child: Icon(icon, color: accent, size: 28),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.navy)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.subdued, height: 1.45)),
                  ],
                ),
              ),
              const SizedBox(width: 9),
              Icon(Icons.arrow_forward_ios_rounded, color: accent, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
