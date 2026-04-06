import '../../../../app/app_router.dart';
import '../../../../core/notifications/notification_unread_store.dart';
import '../../../../core/session/app_session.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../../../../core/widgets/logout_prompt.dart';
import 'package:flutter/material.dart';

enum WerkaDockTab {
  home,
  notifications,
  archive,
  profile,
}

class WerkaDock extends StatelessWidget {
  const WerkaDock({
    super.key,
    required this.activeTab,
    this.compact = true,
    this.tightToEdges = true,
  });

  final WerkaDockTab? activeTab;
  final bool compact;
  final bool tightToEdges;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: NotificationUnreadStore.instance,
      builder: (context, _) {
        final showBadge = NotificationUnreadStore.instance.hasUnreadForProfile(
              AppSession.instance.profile,
            ) &&
            activeTab != WerkaDockTab.notifications;
        return ActionDock(
          compact: compact,
          tightToEdges: tightToEdges,
          leading: [
            DockButton(
              nativeId: 'werka_home',
              nativeSymbol: 'house',
              nativeSelectedSymbol: 'house.fill',
              nativeRouteName: AppRoutes.werkaHome,
              nativeReplaceStack: true,
              icon: Icons.home_outlined,
              selectedIcon: Icons.home_rounded,
              active: activeTab == WerkaDockTab.home,
              compact: compact,
              onTap: () {
                if (activeTab == WerkaDockTab.home) {
                  return;
                }
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.werkaHome,
                  (route) => false,
                );
              },
            ),
            DockButton(
              nativeId: 'werka_notifications',
              nativeSymbol: 'bell',
              nativeSelectedSymbol: 'bell.fill',
              nativeRouteName: AppRoutes.werkaNotifications,
              nativeReplaceStack: true,
              icon: Icons.notifications_outlined,
              selectedIcon: Icons.notifications_rounded,
              active: activeTab == WerkaDockTab.notifications,
              compact: compact,
              showBadge: showBadge,
              onTap: () {
                if (activeTab == WerkaDockTab.notifications) {
                  return;
                }
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.werkaNotifications,
                  (route) => false,
                );
              },
            ),
          ],
          center: DockButton(
            nativeId: 'werka_create',
            nativeSymbol: 'plus',
            nativeSelectedSymbol: 'plus',
            nativeRouteName: AppRoutes.werkaCreateHub,
            icon: Icons.add_rounded,
            selectedIcon: Icons.add_rounded,
            primary: true,
            compact: compact,
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.werkaCreateHub);
            },
          ),
          trailing: [
            DockButton(
              nativeId: 'werka_archive',
              nativeSymbol: 'checklist',
              nativeSelectedSymbol: 'checklist.checked',
              nativeRouteName: AppRoutes.werkaArchive,
              nativeReplaceStack: true,
              iconWidget: const _WerkaDataCheckDockGlyph(),
              selectedIconWidget: const _WerkaDataCheckDockGlyph(active: true),
              active: activeTab == WerkaDockTab.archive,
              compact: compact,
              onTap: () {
                if (activeTab == WerkaDockTab.archive) {
                  return;
                }
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.werkaArchive,
                  (route) => false,
                );
              },
            ),
            DockButton(
              nativeId: 'werka_profile',
              nativeSymbol: 'person.crop.circle',
              nativeSelectedSymbol: 'person.crop.circle.fill',
              nativeRouteName: AppRoutes.profile,
              nativeReplaceStack: true,
              icon: Icons.account_circle_outlined,
              selectedIcon: Icons.account_circle_rounded,
              active: activeTab == WerkaDockTab.profile,
              compact: compact,
              onHoldComplete: activeTab == WerkaDockTab.profile
                  ? () => showLogoutPrompt(context)
                  : null,
              onTap: () {
                if (activeTab == WerkaDockTab.profile) {
                  return;
                }
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.profile,
                  (route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class _WerkaDataCheckDockGlyph extends StatelessWidget {
  const _WerkaDataCheckDockGlyph({
    this.active = false,
  });

  final bool active;

  @override
  Widget build(BuildContext context) {
    final iconTheme = IconTheme.of(context);
    final color = iconTheme.color ?? Theme.of(context).colorScheme.onSurface;
    final size = iconTheme.size ?? 24;
    final bubbleColor = active
        ? color
        : color.withValues(alpha: 0.92);
    final bubbleForeground = active
        ? Theme.of(context).colorScheme.onSecondaryContainer
        : Theme.of(context).colorScheme.surface;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: size * 0.12,
            right: size * 0.34,
            top: size * 0.18,
            child: _DockLine(
              color: color,
              height: size * 0.10,
              radius: size * 0.04,
            ),
          ),
          Positioned(
            left: size * 0.12,
            right: size * 0.20,
            top: size * 0.44,
            child: _DockLine(
              color: color,
              height: size * 0.10,
              radius: size * 0.04,
            ),
          ),
          Positioned(
            left: size * 0.12,
            right: size * 0.28,
            top: size * 0.70,
            child: _DockLine(
              color: color,
              height: size * 0.10,
              radius: size * 0.04,
            ),
          ),
          Positioned(
            right: size * 0.02,
            top: size * 0.02,
            child: Container(
              width: size * 0.42,
              height: size * 0.42,
              decoration: BoxDecoration(
                color: bubbleColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.check_rounded,
                  size: size * 0.28,
                  color: bubbleForeground,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DockLine extends StatelessWidget {
  const _DockLine({
    required this.color,
    required this.height,
    required this.radius,
  });

  final Color color;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
