import '../../../core/theme/app_motion.dart';
import '../../../core/widgets/app_shell.dart';
import 'customer_home_screen.dart';
import 'customer_notifications_screen.dart';
import 'widgets/customer_dock.dart';
import 'package:flutter/material.dart';

class CustomerTabShellScreen extends StatefulWidget {
  const CustomerTabShellScreen({
    super.key,
    required this.initialTab,
  });

  final CustomerDockTab initialTab;

  @override
  State<CustomerTabShellScreen> createState() => _CustomerTabShellScreenState();
}

class _CustomerTabShellScreenState extends State<CustomerTabShellScreen> {
  late final PageController _pageController;
  late CustomerDockTab _activeTab;
  VoidCallback? _notificationsClearAction;

  @override
  void initState() {
    super.initState();
    _activeTab = widget.initialTab;
    _pageController = PageController(
      initialPage: _indexOf(widget.initialTab),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _indexOf(CustomerDockTab tab) {
    switch (tab) {
      case CustomerDockTab.home:
        return 0;
      case CustomerDockTab.notifications:
        return 1;
      case CustomerDockTab.profile:
        return 1;
    }
  }

  CustomerDockTab _tabOf(int index) {
    switch (index) {
      case 0:
        return CustomerDockTab.home;
      default:
        return CustomerDockTab.notifications;
    }
  }

  void _setNotificationsClearAction(VoidCallback? action) {
    if (!mounted) {
      return;
    }
    setState(() {
      _notificationsClearAction = action;
    });
  }

  Future<void> _goToTab(CustomerDockTab tab) async {
    if (_activeTab == tab) {
      return;
    }
    setState(() {
      _activeTab = tab;
    });
    await _pageController.animateToPage(
      _indexOf(tab),
      duration: AppMotion.pageEnter,
      curve: AppMotion.emphasizedDecelerate,
    );
  }

  String get _title {
    switch (_activeTab) {
      case CustomerDockTab.home:
        return 'Customer';
      case CustomerDockTab.notifications:
        return 'Bildirishnomalar';
      case CustomerDockTab.profile:
        return 'Bildirishnomalar';
    }
  }

  List<Widget>? get _actions {
    if (_activeTab == CustomerDockTab.notifications &&
        _notificationsClearAction != null) {
      return [
        AppShellIconAction(
          icon: Icons.cleaning_services_outlined,
          onTap: _notificationsClearAction!,
        ),
      ];
    }
    return null;
  }

  EdgeInsets get _contentPadding {
    return const EdgeInsets.fromLTRB(4, 0, 6, 0);
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: _title,
      subtitle: '',
      animateOnEnter: false,
      actions: _actions,
      bottom: CustomerDock(
        activeTab: _activeTab,
        onTabSelected: _goToTab,
      ),
      contentPadding: _contentPadding,
      child: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          final nextTab = _tabOf(index);
          if (_activeTab != nextTab) {
            setState(() {
              _activeTab = nextTab;
            });
          }
        },
        children: [
          const CustomerHomeScreen(showShell: false),
          CustomerNotificationsScreen(
            showShell: false,
            onClearActionChanged: _setNotificationsClearAction,
          ),
        ],
      ),
    );
  }
}
