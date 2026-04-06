import '../../../app/app_router.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/widgets/app_shell.dart';
import '../../../core/widgets/native_back_button.dart';
import '../../shared/models/app_models.dart';
import 'werka_archive_list_screen.dart';
import 'widgets/werka_dock.dart';
import 'package:flutter/material.dart';

class WerkaArchivePeriodScreen extends StatefulWidget {
  const WerkaArchivePeriodScreen({
    super.key,
    required this.kind,
  });

  final WerkaArchiveKind kind;

  @override
  State<WerkaArchivePeriodScreen> createState() =>
      _WerkaArchivePeriodScreenState();
}

class _WerkaArchivePeriodScreenState extends State<WerkaArchivePeriodScreen> {
  String _kindTitle(AppLocalizations l10n) {
    switch (widget.kind) {
      case WerkaArchiveKind.received:
        return l10n.archiveReceivedTitle;
      case WerkaArchiveKind.sent:
        return l10n.archiveSentTitle;
      case WerkaArchiveKind.returned:
        return l10n.archiveReturnedTitle;
    }
  }

  void _openList(BuildContext context, WerkaArchivePeriod period) {
    if (period == WerkaArchivePeriod.daily) {
      Navigator.of(context).pushNamed(
        AppRoutes.werkaArchiveDailyCalendar,
        arguments: widget.kind,
      );
      return;
    }
    if (period == WerkaArchivePeriod.monthly) {
      Navigator.of(context).pushNamed(
        AppRoutes.werkaArchiveMonthlyCalendar,
        arguments: widget.kind,
      );
      return;
    }
    if (period == WerkaArchivePeriod.yearly) {
      Navigator.of(context).pushNamed(
        AppRoutes.werkaArchiveYearlyCalendar,
        arguments: widget.kind,
      );
      return;
    }
    Navigator.of(context).pushNamed(
      AppRoutes.werkaArchiveList,
      arguments: WerkaArchiveListArgs(
        kind: widget.kind,
        period: period,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    useNativeNavigationTitle(context, _kindTitle(context.l10n));
    return AppShell(
      title: _kindTitle(context.l10n),
      subtitle: context.l10n.archiveChoosePeriod,
      leading: NativeBackButtonSlot(
        onPressed: () => Navigator.of(context).maybePop(),
      ),
      bottom: const WerkaDock(activeTab: null),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(4, 0, 4, 110),
        children: [
          _PeriodGroupCard(
            rows: [
              _PeriodRowData(
                title: context.l10n.archiveDailyTitle,
                onTap: () => _openList(context, WerkaArchivePeriod.daily),
              ),
              _PeriodRowData(
                title: context.l10n.archiveMonthlyTitle,
                onTap: () => _openList(context, WerkaArchivePeriod.monthly),
              ),
              _PeriodRowData(
                title: context.l10n.archiveYearlyTitle,
                onTap: () => _openList(context, WerkaArchivePeriod.yearly),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PeriodRowData {
  const _PeriodRowData({
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;
}

class _PeriodGroupCard extends StatelessWidget {
  const _PeriodGroupCard({
    required this.rows,
  });

  final List<_PeriodRowData> rows;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Card.filled(
      margin: EdgeInsets.zero,
      color: scheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          for (int index = 0; index < rows.length; index++) ...[
            _PeriodRow(
              title: rows[index].title,
              onTap: rows[index].onTap,
              isFirst: index == 0,
              isLast: index == rows.length - 1,
            ),
            if (index != rows.length - 1)
              Divider(
                height: 1,
                thickness: 1,
                indent: 18,
                endIndent: 18,
                color: theme.dividerColor.withValues(alpha: 0.55),
              ),
          ],
        ],
      ),
    );
  }
}

class _PeriodRow extends StatelessWidget {
  const _PeriodRow({
    required this.title,
    required this.onTap,
    required this.isFirst,
    required this.isLast,
  });

  final String title;
  final VoidCallback onTap;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          18,
          isFirst ? 18 : 16,
          18,
          isLast ? 18 : 16,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.titleLarge,
              ),
            ),
            const Icon(Icons.chevron_right_rounded),
          ],
        ),
      ),
    );
  }
}
