import 'package:erpnext_stock_mobile/src/core/notifications/customer_delivery_runtime_store.dart';
import 'package:erpnext_stock_mobile/src/features/shared/models/app_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final store = CustomerDeliveryRuntimeStore.instance;

  setUp(() {
    store.clear();
  });

  DispatchRecord record({
    required String id,
    required DispatchStatus status,
    double sentQty = 1,
    double acceptedQty = 0,
    String note = '',
    String createdLabel = '2026-03-17 06:00:00',
  }) {
    return DispatchRecord(
      id: id,
      supplierRef: 'comfi',
      supplierName: 'comfi',
      itemCode: 'ITEM',
      itemName: 'pista',
      uom: 'Kg',
      sentQty: sentQty,
      acceptedQty: acceptedQty,
      amount: 0,
      currency: '',
      note: note,
      eventType: '',
      highlight: '',
      status: status,
      createdLabel: createdLabel,
    );
  }

  test('moves record from pending to confirmed instantly', () {
    final before = record(id: 'DN-1', status: DispatchStatus.pending);
    final after = record(
      id: 'DN-1',
      status: DispatchStatus.accepted,
      acceptedQty: 1,
      note: 'Customer tasdiqladi.',
    );

    store.recordTransition(before: before, after: after);

    final pending = store.applyStatusList(
      CustomerStatusKind.pending,
      [before],
    );
    final confirmed = store.applyStatusList(
      CustomerStatusKind.confirmed,
      const [],
    );

    expect(pending, isEmpty);
    expect(confirmed.map((item) => item.id), ['DN-1']);
  });

  test('adjusts summary from local mutation', () {
    final before = record(id: 'DN-2', status: DispatchStatus.pending);
    final after = record(
      id: 'DN-2',
      status: DispatchStatus.accepted,
      acceptedQty: 1,
      note: 'Customer tasdiqladi.',
    );

    store.recordTransition(before: before, after: after);

    final summary = store.applySummary(
      const CustomerHomeSummary(
        pendingCount: 3,
        confirmedCount: 4,
        rejectedCount: 0,
      ),
    );

    expect(summary.pendingCount, 2);
    expect(summary.confirmedCount, 5);
    expect(summary.rejectedCount, 0);
  });

  test('reconciles away mutation once server reflects it', () {
    final before = record(id: 'DN-3', status: DispatchStatus.pending);
    final after = record(
      id: 'DN-3',
      status: DispatchStatus.accepted,
      acceptedQty: 1,
      note: 'Customer tasdiqladi.',
    );

    store.recordTransition(before: before, after: after);
    store.reconcileStatusLists(
      pendingItems: const [],
      confirmedItems: [after],
      rejectedItems: const [],
    );

    final summary = store.applySummary(
      const CustomerHomeSummary(
        pendingCount: 0,
        confirmedCount: 1,
        rejectedCount: 0,
      ),
    );
    final confirmed = store.applyStatusList(
      CustomerStatusKind.confirmed,
      [after],
    );

    expect(summary.pendingCount, 0);
    expect(summary.confirmedCount, 1);
    expect(confirmed.length, 1);
  });
}
