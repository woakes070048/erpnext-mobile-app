import '../../../../app/app_router.dart';
import '../../../../core/localization/app_localizations.dart';
import 'package:flutter/material.dart';

Future<void> showWerkaCreateHubSheet(BuildContext context) {
  final theme = Theme.of(context);
  final scheme = theme.colorScheme;

  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    barrierColor: scheme.scrim.withValues(alpha: 0.55),
    builder: (sheetContext) {
      final l10n = context.l10n;
      return Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            color: scheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(28),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: scheme.outlineVariant.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  const SizedBox(height: 14),
                  _WerkaCreateHubActionTile(
                    title: l10n.unannouncedTitle,
                    description: l10n.unannouncedDescription,
                    icon: Icons.inventory_2_outlined,
                    onTap: () => _openRoute(
                      context: context,
                      sheetContext: sheetContext,
                      routeName: AppRoutes.werkaUnannouncedSupplier,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _WerkaCreateHubActionTile(
                    title: l10n.customerIssueTitle,
                    description: l10n.customerIssueDescription,
                    icon: Icons.send_outlined,
                    onTap: () => _openRoute(
                      context: context,
                      sheetContext: sheetContext,
                      routeName: AppRoutes.werkaCustomerIssueCustomer,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _WerkaCreateHubActionTile(
                    title: l10n.batchDispatchTitle,
                    description: l10n.batchDispatchDescription,
                    icon: Icons.playlist_add_check_rounded,
                    onTap: () => _openRoute(
                      context: context,
                      sheetContext: sheetContext,
                      routeName: AppRoutes.werkaBatchDispatch,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void _openRoute({
  required BuildContext context,
  required BuildContext sheetContext,
  required String routeName,
}) {
  Navigator.of(sheetContext).pop();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Navigator.of(context).pushNamed(routeName);
  });
}

class _WerkaCreateHubActionTile extends StatelessWidget {
  const _WerkaCreateHubActionTile({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final iconBackground = scheme.primaryContainer.withValues(alpha: 0.94);
    return Material(
      color: scheme.surfaceContainerHigh.withValues(alpha: 0.8),
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  color: scheme.onPrimaryContainer,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Icon(
                Icons.chevron_right_rounded,
                color: scheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
