import '../../../../app/app_router.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/logout_prompt.dart';
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
    return ActionDock(
      leading: [
        DockButton(
          iconWidget: const DockSvgIcon(
            fillAsset: 'assets/icons/home-fill.svg',
            lineAsset: 'assets/icons/home-line.svg',
            primary: false,
          ),
          active: activeTab == WerkaDockTab.home,
          onTap: () {
            if (activeTab == WerkaDockTab.home) {
              return;
            }
            Navigator.of(context).pushReplacementNamed(AppRoutes.werkaHome);
          },
        ),
        DockButton(
          iconWidget: const DockSvgIcon(
            fillAsset: 'assets/icons/notification-3-fill.svg',
            lineAsset: 'assets/icons/notification-3-line.svg',
            primary: false,
          ),
          active: activeTab == WerkaDockTab.notifications,
          onTap: () {
            if (activeTab == WerkaDockTab.notifications) {
              return;
            }
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
          if (activeTab == WerkaDockTab.home) {
            return;
          }
          Navigator.of(context).pushReplacementNamed(AppRoutes.werkaHome);
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
            if (activeTab == WerkaDockTab.profile) {
              showLogoutPrompt(context);
              return;
            }
            Navigator.of(context).pushReplacementNamed(AppRoutes.profile);
          },
        ),
      ],
    );
  }
}
