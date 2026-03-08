import '../../../../app/app_router.dart';
import '../../../../core/session/app_session.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../shared/models/app_models.dart';
import 'package:flutter/material.dart';

enum WerkaDockTab {
  home,
  notifications,
  profile,
}

class WerkaDock extends StatelessWidget {
  const WerkaDock({
    super.key,
    required this.activeTab,
  });

  final WerkaDockTab activeTab;

  @override
  Widget build(BuildContext context) {
    final profile = AppSession.instance.profile;

    return ActionDock(
      leading: [
        DockButton(
          icon: Icons.home_rounded,
          active: activeTab == WerkaDockTab.home,
          onTap: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.werkaHome,
              (route) => false,
            );
          },
        ),
        DockButton(
          icon: Icons.notifications_none_rounded,
          active: activeTab == WerkaDockTab.notifications,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Werka bildirishnomalari keyingi bosqichda')),
            );
          },
        ),
      ],
      center: DockButton(
        icon: Icons.inventory_2_outlined,
        primary: true,
        onTap: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.werkaHome,
            (route) => false,
          );
        },
      ),
      trailing: [
        DockButton(
          icon: Icons.history_rounded,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Werka recent keyingi bosqichda')),
            );
          },
        ),
        DockButton(
          icon: Icons.person_outline_rounded,
          active: activeTab == WerkaDockTab.profile,
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.profile,
              arguments: ProfileArgs(
                role: UserRole.werka,
                name: profile?.displayName ?? 'Werka',
                subtitle: 'Pending qabul qilish va tasdiqlash bilan ishlaydi',
              ),
            );
          },
        ),
      ],
    );
  }
}
