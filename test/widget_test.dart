import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:v_green_media/data/enquiry.dart';
import 'package:v_green_media/data/products.dart';
import 'package:v_green_media/main.dart';
import 'package:v_green_media/services/whatsapp_service.dart';
import 'package:v_green_media/services/product_sharing_service.dart';
import 'package:v_green_media/services/enquiry_service.dart';
import 'package:v_green_media/screens/enquiry_form_page.dart';
import 'package:v_green_media/screens/my_enquiries_page.dart';
import 'package:v_green_media/screens/thank_you_page.dart';

void main() {
  test(
    'product WhatsApp link opens the business chat with product details',
    () {
      final uri = productWhatsAppUri(products.first);

      expect(uri.host, 'wa.me');
      expect(uri.path, '/917207967958');
      expect(uri.queryParameters['text'], contains(products.first.name));
      expect(uri.queryParameters['text'], contains('pricing'));
    },
  );

  test(
    'product share payload includes the title, description, and image',
    () async {
      final product = products.first;
      final imageBytes = Uint8List.fromList([1, 2, 3]);
      final params = productShareParams(product, imageBytes);

      expect(params.title, product.name);
      expect(params.text, product.description);
      expect(params.downloadFallbackEnabled, isFalse);
      expect(params.files, hasLength(1));
      expect(params.files!.single.mimeType, 'image/jpeg');
      expect(
        await params.files!.single.readAsBytes(),
        orderedEquals(imageBytes),
      );
    },
  );

  test('Firestore enquiry data uses the expected document fields', () {
    final deliveryDate = DateTime(2026, 12, 1);
    final enquiry = Enquiry(
      id: '1',
      name: 'Taylor Green',
      company: 'Green Co',
      phone: '1234567890',
      email: 'taylor@example.com',
      occasion: 'Employee Onboarding',
      units: 25,
      budgetPerUnit: 500.5,
      deliveryDate: deliveryDate,
      products: const ['Plantable Seed Cards', 'Everyday Canvas Tote'],
      customisations: const ['Logo printing'],
      otherCustomisation: 'Use recycled packaging',
      message: 'Please share a quote',
      submittedAt: DateTime(2026, 10, 31),
      submittedFrom: kIsWeb ? EnquirySource.web : EnquirySource.mobile,
    );

    final documentData = EnquiryService.toFirestoreData(enquiry);
    expect(documentData.keys, {
      'budget_per_unit',
      'company',
      'customisation_needed',
      'delivery_date',
      'email',
      'enquiry_from',
      'message',
      'name',
      'number_of_units',
      'occasion',
      'other_info',
      'phone',
      'products_selected',
      'submitted_at',
    });
    expect(documentData['budget_per_unit'], 500.5);
    expect(documentData['customisation_needed'], ['Logo printing']);
    expect(documentData['delivery_date'], Timestamp.fromDate(deliveryDate));
    expect(documentData['enquiry_from'], kIsWeb ? 'web' : 'mobile');
    expect(documentData['number_of_units'], 25);
    expect(documentData['other_info'], 'Use recycled packaging');
    expect(documentData['products_selected'], [
      'Plantable Seed Cards',
      'Everyday Canvas Tote',
    ]);
    expect(
      documentData['submitted_at'],
      Timestamp.fromDate(DateTime(2026, 10, 31)),
    );
  });

  testWidgets('catalog provides access to my enquiries', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const MyApp());

    expect(find.byTooltip('My enquiries'), findsOneWidget);
  });

  testWidgets('my enquiries shows an empty state when there are no entries', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const MaterialApp(home: MyEnquiriesPage()));
    await tester.pumpAndSettle();

    expect(find.text('No enquiries yet'), findsOneWidget);
    expect(find.text('Make an enquiry'), findsOneWidget);
  });

  testWidgets('my enquiries lists saved local enquiries', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await EnquiryStore().save(
      Enquiry(
        id: '1',
        name: 'Taylor Green',
        company: 'Green Co',
        phone: '1234567890',
        email: 'taylor@example.com',
        occasion: 'Employee Onboarding',
        units: 25,
        budgetPerUnit: 500,
        deliveryDate: DateTime(2026, 12, 1),
        products: const ['Plantable Seed Cards'],
        customisations: const ['Logo printing'],
        otherCustomisation: '',
        message: '',
        submittedAt: DateTime(2026, 10, 31),
        submittedFrom: kIsWeb ? EnquirySource.web : EnquirySource.mobile,
      ),
    );

    await tester.pumpWidget(const MaterialApp(home: MyEnquiriesPage()));
    await tester.pumpAndSettle();

    expect(find.text('Plantable Seed Cards'), findsOneWidget);
    expect(find.text('Employee Onboarding · 25 units'), findsOneWidget);
    expect(find.text('From ${kIsWeb ? 'Web' : 'Mobile'}'), findsOneWidget);
    await tester.tap(find.text('Plantable Seed Cards'));
    await tester.pumpAndSettle();
    expect(find.text('Enquiry details'), findsOneWidget);
    expect(find.textContaining('taylor@example.com'), findsOneWidget);
    expect(
      find.textContaining('Submitted from: ${kIsWeb ? 'Web' : 'Mobile'}'),
      findsOneWidget,
    );
    expect(find.text('Submitted to V Green Media.'), findsOneWidget);
  });

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
    expect(find.byTooltip('Share product'), findsOneWidget);
    expect(find.text('Chat about this product on WhatsApp'), findsOneWidget);
    expect(find.text('Weddings'), findsOneWidget);
    expect(find.text('Logo printing'), findsOneWidget);
    expect(find.text('Name personalisation'), findsOneWidget);
    expect(find.text('Enquire about this product'), findsOneWidget);
  });

  testWidgets('budget band filters products', (tester) async {
    await tester.pumpWidget(const MyApp());

    final budget = find.text('Under ₹500');
    await tester.tap(budget);
    await tester.pumpAndSettle();

    expect(find.text('6 products'), findsOneWidget);
  });

  testWidgets('search filters catalog by product name', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byTooltip('Search products'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'journal');
    await tester.tap(find.text('Search'));
    await tester.pumpAndSettle();

    expect(find.text('1 products'), findsOneWidget);
    final journal = find.text('Recycled Paper Journal');
    await tester.scrollUntilVisible(
      journal,
      250,
      scrollable: find.byType(Scrollable).first,
    );
    expect(journal, findsOneWidget);
    expect(find.text('Plantable Seed Cards'), findsNothing);
  });

  testWidgets('enquiry form shows requested order fields', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: EnquiryFormPage()));
    await tester.pumpAndSettle();

    expect(find.text('Product enquiry'), findsOneWidget);
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Company'), findsOneWidget);
    expect(find.text('Phone'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Occasion'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Budget per unit'),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Number of units'), findsOneWidget);
    expect(find.text('Budget per unit'), findsOneWidget);
    expect(find.text('Delivery date'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Products selected'),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Products selected'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Customisation needed'),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Customisation needed'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Message (optional)'),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Message (optional)'), findsOneWidget);
  });

  testWidgets('enquiry form validates phone and email during entry', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: EnquiryFormPage()));
    await tester.pumpAndSettle();

    final nameField = find.byWidgetPredicate(
      (widget) => widget is TextField && widget.decoration?.labelText == 'Name',
    );
    final companyField = find.byWidgetPredicate(
      (widget) =>
          widget is TextField && widget.decoration?.labelText == 'Company',
    );
    final phoneField = find.byWidgetPredicate(
      (widget) =>
          widget is TextField && widget.decoration?.labelText == 'Phone',
    );
    final emailField = find.byWidgetPredicate(
      (widget) =>
          widget is TextField && widget.decoration?.labelText == 'Email',
    );

    expect(
      tester.widget<TextField>(phoneField).keyboardType,
      TextInputType.number,
    );
    await tester.tap(nameField);
    await tester.pumpAndSettle();
    expect(find.text('Enter your name'), findsOneWidget);

    await tester.tap(companyField);
    await tester.pumpAndSettle();
    expect(find.text('Enter your company name'), findsOneWidget);

    await tester.tap(phoneField);
    await tester.pumpAndSettle();
    expect(find.text('Enter your phone number'), findsOneWidget);

    await tester.enterText(phoneField, '123456789');
    await tester.pumpAndSettle();
    expect(find.text('Enter your phone number'), findsNothing);
    expect(find.text('Enter a valid phone number'), findsOneWidget);

    await tester.enterText(phoneField, '1234567890');
    await tester.pumpAndSettle();
    expect(find.text('Enter a valid phone number'), findsNothing);

    await tester.enterText(phoneField, '123456789012');
    await tester.pumpAndSettle();
    expect(tester.widget<TextField>(phoneField).controller!.text, '1234567890');

    await tester.enterText(emailField, 'not-an-email');
    await tester.pumpAndSettle();
    expect(find.text('Enter a valid email address'), findsOneWidget);
  });

  testWidgets('thank-you screen confirms enquiry without a dialog', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: ThankYouPage()));
    await tester.pumpAndSettle();

    expect(find.text('Thank you for your enquiry!'), findsOneWidget);
    expect(find.text('View my enquiries'), findsOneWidget);
    expect(find.text('Continue browsing'), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
  });
}
