import 'package:flutter_test/flutter_test.dart';

import 'package:v_green_media/main.dart';

void main() {
  testWidgets('catalog shows products and product details', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Thoughtful gifts.\nA greener tomorrow.'), findsOneWidget);
    expect(find.text('8 products'), findsOneWidget);
    expect(find.text('Plantable Seed Cards'), findsOneWidget);

    final firstProduct = find.text('Plantable Seed Cards');
    await tester.ensureVisible(firstProduct);
    await tester.pumpAndSettle();
    await tester.tap(firstProduct);
    await tester.pumpAndSettle();
    expect(find.text('Perfect for'), findsOneWidget);
    expect(find.text('Make it yours'), findsOneWidget);
    expect(find.text('Weddings'), findsOneWidget);
  });
}
