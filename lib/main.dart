import 'package:flutter/material.dart';

import 'screens/product_catalog_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const forest = Color(0xFF174B3A);
    return MaterialApp(
      title: 'V Green Media',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F8F3),
        colorScheme: ColorScheme.fromSeed(
          seedColor: forest,
          primary: forest,
          surface: const Color(0xFFF7F8F3),
        ),
        fontFamily: 'Roboto',
      ),
      home: const ProductCatalogPage(),
    );
  }
}

// static development complted.
