import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:v_green_media/main.dart';

void main() {
  testWidgets('catalog shows products and product details', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Thoughtful gifts.\nA greener tomorrow.'), findsOneWidget);
    expect(find.text('8 products'), findsOneWidget);

    final firstProduct = find.text('Plantable Seed Cards');
    await tester.scrollUntilVisible(
      firstProduct,
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(firstProduct);
    await tester.pumpAndSettle();
    expect(find.text('Perfect for'), findsOneWidget);
    expect(find.text('Make it yours'), findsOneWidget);
    expect(find.text('Weddings'), findsOneWidget);
    expect(find.text('Logo printing'), findsOneWidget);
    expect(find.text('Name personalisation'), findsOneWidget);
  });

  testWidgets('budget band filters products', (tester) async {
    await tester.pumpWidget(const MyApp());

    final budget = find.text('Under ₹500');
    await tester.tap(budget);
    await tester.pumpAndSettle();

    expect(find.text('6 products'), findsOneWidget);
  });
}
