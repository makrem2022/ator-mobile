import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hotel_audit_mobile/app/app.dart';

void main() {
  testWidgets('app redirects to login when unauthenticated', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: HotelAuditApp()));
    await tester.pumpAndSettle();

    expect(find.text('Login'), findsWidgets);
    expect(find.text('Hotel Audit Mobile'), findsOneWidget);
  });
}
