import '../../../core/api/mobile_api.dart';
import '../../../app/app_router.dart';
import '../../../core/notifications/refresh_hub.dart';
import '../../../core/widgets/app_shell.dart';
import '../../../core/widgets/common_widgets.dart';
import '../../shared/models/app_models.dart';
import 'widgets/admin_dock.dart';
import 'widgets/admin_module_card.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  late Future<AdminSupplierSummary> _summaryFuture;
  int _refreshVersion = 0;

  @override
  void initState() {
    super.initState();
    _summaryFuture = MobileApi.instance.adminSupplierSummary();
    RefreshHub.instance.addListener(_handlePushRefresh);
  }

  @override
  void dispose() {
    RefreshHub.instance.removeListener(_handlePushRefresh);
    super.dispose();
  }

  void _handlePushRefresh() {
    if (!mounted || RefreshHub.instance.topic != 'admin') {
      return;
    }
    if (_refreshVersion == RefreshHub.instance.version) {
      return;
    }
    _refreshVersion = RefreshHub.instance.version;
    _reload();
  }

  Future<void> _reload() async {
    final future = MobileApi.instance.adminSupplierSummary();
    setState(() {
      _summaryFuture = future;
    });
    await future;
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Admin',
      subtitle: '',
      bottom: const AdminDock(activeTab: AdminDockTab.home),
      child: FutureBuilder<AdminSupplierSummary>(
        future: _summaryFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: SoftCard(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Admin summary yuklanmadi: ${snapshot.error}'),
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: _reload,
                      child: const Text('Qayta urinish'),
                    ),
                  ],
                ),
              ),
            );
          }

          final summary = snapshot.data!;
          return RefreshIndicator(
            onRefresh: _reload,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                if (summary.blockedSuppliers > 0) ...[
                  InkWell(
                    borderRadius: BorderRadius.circular(24),
                    onTap: () => Navigator.of(context)
                        .pushNamed(AppRoutes.adminInactiveSuppliers),
                    child: SoftCard(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.block_rounded,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Bloklangan supplierlar: ${summary.blockedSuppliers} ta',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          const Icon(Icons.arrow_forward_rounded),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                Row(
                  children: [
                    Expanded(
                      child: MetricBadge(
                        label: 'Aktiv supplierlar',
                        value: '${summary.activeSuppliers}',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: MetricBadge(
                        label: 'Jami supplierlar',
                        value: '${summary.totalSuppliers}',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                AdminModuleCard(
                  title: 'Settings',
                  subtitle: 'ERP va default sozlamalar',
                  onTap: () =>
                      Navigator.of(context).pushNamed(AppRoutes.adminSettings),
                ),
                const SizedBox(height: 12),
                AdminModuleCard(
                  title: 'Suppliers',
                  subtitle: 'List, mahsulot biriktirish va block nazorati',
                  onTap: () =>
                      Navigator.of(context).pushNamed(AppRoutes.adminSuppliers),
                ),
                const SizedBox(height: 12),
                AdminModuleCard(
                  title: 'Werka',
                  subtitle: 'Omborchi phone va name',
                  onTap: () =>
                      Navigator.of(context).pushNamed(AppRoutes.adminWerka),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
