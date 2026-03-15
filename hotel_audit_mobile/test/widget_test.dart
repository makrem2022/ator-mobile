import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_audit_mobile/app/app.dart';

void main() {
  testWidgets('app boots with Splash placeholder', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: HotelAuditApp()));
    await tester.pumpAndSettle();

    expect(find.text('Splash'), findsNWidgets(2));
  });
}
