import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'services/page_metadata.dart';
import 'screens/product_catalog_page.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  setPageMetadata(
    title: 'V Green Media | Thoughtful Sustainable Gifts',
    description:
        'Discover thoughtful, customisable sustainable gifts for teams, '
        'clients, and special occasions.',
    imageUrl:
        'https://images.unsplash.com/photo-1490750967868-88aa4486c946?auto=format&fit=crop&w=1200&h=630&q=85',
  );
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
