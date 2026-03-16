import '../../../app/app_router.dart';
import '../../../core/api/mobile_api.dart';
import '../../../core/cache/json_cache_store.dart';
import '../../../core/notifications/refresh_hub.dart';
import '../../../core/widgets/app_shell.dart';
import '../../shared/models/app_models.dart';
import 'werka_customer_issue_customer_screen.dart';
import 'werka_unannounced_supplier_screen.dart';
import 'widgets/werka_dock.dart';
import 'package:flutter/material.dart';

class WerkaRecentScreen extends StatefulWidget {
  const WerkaRecentScreen({super.key});

  @override
  State<WerkaRecentScreen> createState() => _WerkaRecentScreenState();
}

class _WerkaRecentScreenState extends State<WerkaRecentScreen> {
  static const String _cacheKey = 'cache_werka_recent';
  late Future<List<DispatchRecord>> _future;
  List<DispatchRecord>? _cachedItems;
  int _refreshVersion = 0;

  @override
  void initState() {
    super.initState();
    _future = MobileApi.instance.werkaHistory();
    _loadCache();
    RefreshHub.instance.addListener(_handlePushRefresh);
  }

  @override
  void dispose() {
    RefreshHub.instance.removeListener(_handlePushRefresh);
    super.dispose();
  }

  Future<void> _loadCache() async {
    final raw = await JsonCacheStore.instance.readList(_cacheKey);
    if (raw == null || !mounted) {
      return;
    }
    setState(() {
      _cachedItems = raw.map((item) => DispatchRecord.fromJson(item)).toList();
    });
  }

  void _handlePushRefresh() {
    if (!mounted || RefreshHub.instance.topic != 'werka') {
      return;
    }
    if (_refreshVersion == RefreshHub.instance.version) {
      return;
    }
    _refreshVersion = RefreshHub.instance.version;
    _reload();
  }

  Future<void> _reload() async {
    final future = MobileApi.instance.werkaHistory();
    setState(() => _future = future);
    final items = await future;
    await JsonCacheStore.instance.writeList(
      _cacheKey,
      items.map((item) => item.toJson()).toList(),
    );
  }

  bool _usesCustomerFlow(DispatchRecord record) {
    return record.eventType.startsWith('customer_delivery_');
  }

  Future<void> _repeat(DispatchRecord record) async {
    if (_usesCustomerFlow(record)) {
      await Navigator.of(context).pushNamed(
        AppRoutes.werkaCustomerIssueCustomer,
        arguments: WerkaCustomerIssuePrefillArgs(
          customerRef: record.supplierRef,
          customerName: record.supplierName,
          itemCode: record.itemCode,
          itemName: record.itemName,
          qty: record.sentQty,
          uom: record.uom,
        ),
      );
      return;
    }
    await Navigator.of(context).pushNamed(
      AppRoutes.werkaUnannouncedSupplier,
      arguments: WerkaUnannouncedPrefillArgs(
        supplierRef: record.supplierRef,
        supplierName: record.supplierName,
        itemCode: record.itemCode,
        itemName: record.itemName,
        qty: record.sentQty,
        uom: record.uom,
      ),
    );
  }

  String _headline(DispatchRecord record) {
    return record.itemCode.trim().isEmpty ? record.itemName : record.itemCode;
  }

  String _subline(DispatchRecord record) {
    return '${record.supplierName} • ${record.itemName}';
  }

  String _metric(DispatchRecord record) {
    final sent = '${record.sentQty.toStringAsFixed(0)} ${record.uom}';
    if (_usesCustomerFlow(record)) {
      return '$sent customerga yuborilgan';
    }
    return '$sent supplierdan qabul qilingan';
  }

  String _actionLabel(DispatchRecord record) {
    return _usesCustomerFlow(record) ? 'Yana jo‘natish' : 'Yana qayd qilish';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return AppShell(
      title: 'Recent',
      subtitle: 'Avvalgi harakatni prefill bilan qayta ishlating',
      bottom: const WerkaDock(activeTab: WerkaDockTab.recent),
      contentPadding: const EdgeInsets.fromLTRB(10, 0, 12, 0),
      child: FutureBuilder<List<DispatchRecord>>(
        future: _future,
        builder: (context, snapshot) {
          final items =
              snapshot.data ?? _cachedItems ?? const <DispatchRecord>[];
          if (snapshot.connectionState != ConnectionState.done &&
              items.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError && items.isEmpty) {
            return Center(
              child: Card.filled(
                margin: EdgeInsets.zero,
                color: scheme.surfaceContainerLow,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recent yuklanmadi',
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text('${snapshot.error}'),
                      const SizedBox(height: 14),
                      FilledButton(
                        onPressed: _reload,
                        child: const Text('Qayta urinish'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          if (items.isEmpty) {
            return Center(
              child: Card.filled(
                margin: EdgeInsets.zero,
                color: scheme.surfaceContainerLow,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Text(
                    'Hali repeat qilish uchun recent harakat yo‘q.',
                    style: theme.textTheme.titleMedium,
                  ),
                ),
              ),
            );
          }
          return RefreshIndicator.adaptive(
            onRefresh: _reload,
            child: ListView(
              padding: const EdgeInsets.only(bottom: 110),
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                Card.filled(
                  margin: EdgeInsets.zero,
                  color: scheme.surfaceContainerLow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Column(
                    children: [
                      for (int index = 0; index < items.length; index++) ...[
                        _WerkaRecentRow(
                          record: items[index],
                          headline: _headline(items[index]),
                          subline: _subline(items[index]),
                          metric: _metric(items[index]),
                          actionLabel: _actionLabel(items[index]),
                          onRepeat: () => _repeat(items[index]),
                        ),
                        if (index != items.length - 1)
                          const Divider(height: 1, thickness: 1),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _WerkaRecentRow extends StatelessWidget {
  const _WerkaRecentRow({
    required this.record,
    required this.headline,
    required this.subline,
    required this.metric,
    required this.actionLabel,
    required this.onRepeat,
  });

  final DispatchRecord record;
  final String headline;
  final String subline;
  final String metric;
  final String actionLabel;
  final VoidCallback onRepeat;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  headline,
                  style: theme.textTheme.titleLarge,
                ),
              ),
              FilledButton.tonal(
                onPressed: onRepeat,
                style: FilledButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                ),
                child: Text(actionLabel),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            subline,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  metric,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                record.createdLabel,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          if (record.highlight.trim().isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              record.highlight,
              style: theme.textTheme.bodySmall?.copyWith(
                color: scheme.primary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
