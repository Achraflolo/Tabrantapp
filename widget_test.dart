import 'package:flutter_test/flutter_test.dart';
import 'package:tabrante/main.dart';

void main() {
  testWidgets('welcome screen renders', (tester) async {
    await tester.pumpWidget(const TabranteApp());
    expect(find.text('تبرانت'), findsOneWidget);
    expect(find.text('الدخول إلى التطبيق'), findsOneWidget);
  });
}
