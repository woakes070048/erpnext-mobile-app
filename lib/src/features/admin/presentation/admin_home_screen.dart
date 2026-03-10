import '../../../app/app_router.dart';
import '../../../core/widgets/app_shell.dart';
import '../../../core/widgets/common_widgets.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Admin',
      subtitle: 'Minimal boshqaruv paneli.',
      actions: [
        AppShellIconAction(
          icon: Icons.person_outline_rounded,
          onTap: () => Navigator.of(context).pushNamed(AppRoutes.profile),
        ),
      ],
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _AdminActionTile(
            title: 'Settings',
            subtitle: 'ERP va default sozlamalar',
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.adminSettings),
          ),
          const SizedBox(height: 12),
          _AdminActionTile(
            title: 'Suppliers',
            subtitle: 'Supplier va code ro‘yxati',
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.adminSuppliers),
          ),
        ],
      ),
    );
  }
}

class _AdminActionTile extends StatelessWidget {
  const _AdminActionTile({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: SoftCard(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 6),
                  Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_rounded),
          ],
        ),
      ),
    );
  }
}
