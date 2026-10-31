import 'package:flutter/material.dart';

const occasions = [
  'Employee Onboarding',
  'Corporate Diwali Gifting',
  'New Year Gifts',
  'Client and Vendor Gifting',
  'Events and Trade Shows',
  'Employee Recognition',
];

void main() {
  runApp(const MyApp());
}

class Product {
  const Product({
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.description,
    required this.price,
    required this.occasions,
    required this.customisation,
    required this.icon,
  });

  final String name;
  final String imageUrl;
  final String category;
  final String description;
  final String price;
  final List<String> occasions;
  final String customisation;
  final IconData icon;
}

const products = [
  Product(
    name: 'Plantable Seed Cards',
    imageUrl:
        'https://images.unsplash.com/photo-1455390582262-044cmaa2d6d8?auto=format&fit=crop&w=900&q=85',
    category: 'Paper goods',
    description:
        'Thoughtful handmade cards embedded with seeds that grow into a little patch of wildflowers.',
    price: '₹35–₹75 / card',
    occasions: [
      'Weddings',
      'Thank you',
      'Festivals',
      'Client and Vendor Gifting',
      'Events and Trade Shows',
      'Employee Recognition',
    ],
    customisation:
        'Choose seed mix, paper colour, message, and printed artwork.',
    icon: Icons.local_florist_outlined,
  ),
  Product(
    name: 'Everyday Canvas Tote',
    imageUrl:
        'https://images.unsplash.com/photo-1590874103328-eac38a683ce7?auto=format&fit=crop&w=900&q=85',
    category: 'Carry goods',
    description:
        'A sturdy, reusable cotton tote made for errands, events, and everyday adventures.',
    price: '₹249–₹499 / bag',
    occasions: [
      'Welcome kits',
      'Birthdays',
      'Conferences',
      'Employee Onboarding',
      'Events and Trade Shows',
      'Employee Recognition',
    ],
    customisation:
        'Add a logo or illustration; select print colour and handle length.',
    icon: Icons.shopping_bag_outlined,
  ),
  Product(
    name: 'Bamboo Desk Planter',
    imageUrl:
        'https://images.unsplash.com/photo-1485955900006-10f4d324d411?auto=format&fit=crop&w=900&q=85',
    category: 'Green living',
    description:
        'A compact planter that brings a calm, natural touch to desks and windowsills.',
    price: '₹399–₹799 / planter',
    occasions: [
      'Housewarming',
      'Employee gifts',
      'Thank you',
      'Employee Onboarding',
      'Corporate Diwali Gifting',
      'New Year Gifts',
      'Client and Vendor Gifting',
      'Employee Recognition',
    ],
    customisation:
        'Pick the plant, planter finish, and a personalised name tag.',
    icon: Icons.eco_outlined,
  ),
  Product(
    name: 'Insulated Steel Bottle',
    imageUrl:
        'https://images.unsplash.com/photo-1602143407151-7111542de6e8?auto=format&fit=crop&w=900&q=85',
    category: 'Green living',
    description:
        'A double-wall bottle that keeps drinks at the right temperature while reducing single-use waste.',
    price: '₹599–₹1,099 / bottle',
    occasions: [
      'Corporate gifts',
      'Travel',
      'Sports events',
      'Employee Onboarding',
      'Corporate Diwali Gifting',
      'New Year Gifts',
      'Client and Vendor Gifting',
      'Events and Trade Shows',
      'Employee Recognition',
    ],
    customisation:
        'Choose capacity and colour, with optional name or logo engraving.',
    icon: Icons.water_drop_outlined,
  ),
  Product(
    name: 'Recycled Paper Journal',
    imageUrl:
        'https://images.unsplash.com/photo-1517842645767-c639042777db?auto=format&fit=crop&w=900&q=85',
    category: 'Paper goods',
    description:
        'A lovely everyday notebook with recycled pages for ideas, plans, and sketches.',
    price: '₹199–₹449 / journal',
    occasions: [
      'Back to school',
      'Workshops',
      'Welcome kits',
      'Employee Onboarding',
      'Corporate Diwali Gifting',
      'New Year Gifts',
      'Client and Vendor Gifting',
      'Events and Trade Shows',
      'Employee Recognition',
    ],
    customisation:
        'Personalise the cover, page layout, binding, and elastic band colour.',
    icon: Icons.menu_book_outlined,
  ),
  Product(
    name: 'Reusable Coffee Cup',
    imageUrl:
        'https://images.unsplash.com/photo-1517701604599-bb29b565090c?auto=format&fit=crop&w=900&q=85',
    category: 'Green living',
    description:
        'A lightweight, reusable cup for coffee on the go and slower mornings at home.',
    price: '₹299–₹649 / cup',
    occasions: [
      'Festivals',
      'Team celebrations',
      'New year',
      'Employee Onboarding',
      'Corporate Diwali Gifting',
      'New Year Gifts',
      'Client and Vendor Gifting',
      'Employee Recognition',
    ],
    customisation:
        'Select cup size, lid colour, and a printed or engraved design.',
    icon: Icons.coffee_outlined,
  ),
  Product(
    name: 'Mini Herb Garden Kit',
    imageUrl:
        'https://images.unsplash.com/photo-1466692476868-aef1dfb1e735?auto=format&fit=crop&w=900&q=85',
    category: 'Green living',
    description:
        'Everything needed to grow fresh herbs at home, packed as a cheerful little gift.',
    price: '₹349–₹699 / kit',
    occasions: [
      'Housewarming',
      'Mother’s Day',
      'Thank you',
      'Corporate Diwali Gifting',
      'New Year Gifts',
      'Client and Vendor Gifting',
      'Employee Recognition',
    ],
    customisation:
        'Choose three herb seeds, pot style, and a custom care card.',
    icon: Icons.grass_outlined,
  ),
  Product(
    name: 'Sustainable Gift Hamper',
    imageUrl:
        'https://images.unsplash.com/photo-1549465220-1a8b9238cd48?auto=format&fit=crop&w=900&q=85',
    category: 'Gift sets',
    description:
        'A considered bundle of useful, planet-friendly favourites, ready to make someone smile.',
    price: '₹899–₹2,499 / hamper',
    occasions: [
      'Diwali',
      'Weddings',
      'Corporate gifting',
      'Employee Onboarding',
      'Corporate Diwali Gifting',
      'New Year Gifts',
      'Client and Vendor Gifting',
      'Events and Trade Shows',
      'Employee Recognition',
    ],
    customisation:
        'Build your own bundle, choose a note, and personalise the outer packaging.',
    icon: Icons.redeem_outlined,
  ),
];

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

class ProductCatalogPage extends StatefulWidget {
  const ProductCatalogPage({super.key});

  @override
  State<ProductCatalogPage> createState() => _ProductCatalogPageState();
}

class _ProductCatalogPageState extends State<ProductCatalogPage> {
  String _selectedCategory = 'All';
  String _selectedOccasion = 'All';
  String _searchQuery = '';

  List<String> get _categories => [
    'All',
    ...products.map((product) => product.category).toSet(),
  ];

  List<Product> get _visibleProducts {
    final query = _searchQuery.trim().toLowerCase();
    return products.where((product) {
      final matchesCategory =
          _selectedCategory == 'All' || product.category == _selectedCategory;
      final matchesOccasion =
          _selectedOccasion == 'All' ||
          product.occasions.contains(_selectedOccasion);
      final matchesSearch =
          query.isEmpty ||
          product.name.toLowerCase().contains(query) ||
          product.description.toLowerCase().contains(query) ||
          product.category.toLowerCase().contains(query) ||
          product.occasions.any(
            (occasion) => occasion.toLowerCase().contains(query),
          );
      return matchesCategory && matchesOccasion && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final columns = width >= 1050
        ? 3
        : width >= 680
        ? 2
        : 1;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),
            SliverToBoxAdapter(child: _buildIntro()),
            SliverToBoxAdapter(child: _buildFilters()),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(22, 8, 22, 32),
              sliver: _visibleProducts.isEmpty
                  ? SliverToBoxAdapter(child: _buildEmptyState())
                  : SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => _ProductCard(
                          product: _visibleProducts[index],
                          selectedOccasion: _selectedOccasion,
                          onTap: () => _showProductDetails(
                            context,
                            _visibleProducts[index],
                          ),
                        ),
                        childCount: _visibleProducts.length,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns,
                        crossAxisSpacing: 18,
                        mainAxisSpacing: 18,
                        mainAxisExtent: 395,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 14, 22, 8),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFE2EEE4),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.eco_rounded, color: Color(0xFF174B3A)),
          ),
          const SizedBox(width: 11),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'V GREEN',
                style: TextStyle(
                  color: Color(0xFF174B3A),
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),
              Text(
                'MEDIA & MEANINGFUL GIFTS',
                style: TextStyle(
                  color: Color(0xFF78847A),
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            tooltip: 'Search products',
            onPressed: _showSearch,
            icon: const Icon(Icons.search_rounded),
          ),
        ],
      ),
    );
  }

  Widget _buildIntro() {
    return Container(
      margin: const EdgeInsets.fromLTRB(22, 14, 22, 20),
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFFE5F0E4), Color(0xFFF0F1E6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.72),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              'GIVE A LITTLE GOOD',
              style: TextStyle(
                color: Color(0xFF3D7356),
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'Thoughtful gifts.\nA greener tomorrow.',
            style: TextStyle(
              color: Color(0xFF183D30),
              fontSize: 29,
              height: 1.14,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.7,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Discover useful, customisable products made for\n'
            'the moments worth remembering.',
            style: TextStyle(
              color: Color(0xFF5E7064),
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              const Icon(
                Icons.spa_outlined,
                size: 17,
                color: Color(0xFF4E7859),
              ),
              const SizedBox(width: 7),
              Text(
                '${products.length} feel-good finds',
                style: const TextStyle(
                  color: Color(0xFF315B40),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 15),
              const Icon(
                Icons.tune_rounded,
                size: 16,
                color: Color(0xFF4E7859),
              ),
              const SizedBox(width: 6),
              const Text(
                'Made personal',
                style: TextStyle(
                  color: Color(0xFF315B40),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(22, 3, 22, 12),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Find your favourite',
                  style: TextStyle(
                    color: Color(0xFF20352A),
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                '${_visibleProducts.length} products',
                style: const TextStyle(
                  color: Color(0xFF7C877E),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(22, 0, 22, 9),
          child: Text(
            'Shop by occasion',
            style: TextStyle(
              color: Color(0xFF536359),
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          height: 44,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            scrollDirection: Axis.horizontal,
            itemCount: occasions.length + 1,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final occasion = index == 0 ? 'All' : occasions[index - 1];
              final selected = occasion == _selectedOccasion;
              return ChoiceChip(
                label: Text(occasion),
                selected: selected,
                showCheckmark: false,
                onSelected: (value) {
                  setState(() => _selectedOccasion = occasion);
                },
                labelStyle: TextStyle(
                  color: selected ? Colors.white : const Color(0xFF536359),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
                selectedColor: const Color(0xFF174B3A),
                backgroundColor: Colors.white,
                side: BorderSide(
                  color: selected
                      ? const Color(0xFF174B3A)
                      : const Color(0xFFE6E9E3),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        const Padding(
          padding: EdgeInsets.fromLTRB(22, 0, 22, 9),
          child: Text(
            'Shop by category',
            style: TextStyle(
              color: Color(0xFF536359),
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          height: 44,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final category = _categories[index];
              final selected = category == _selectedCategory;
              return ChoiceChip(
                label: Text(category),
                selected: selected,
                showCheckmark: false,
                onSelected: (value) {
                  setState(() => _selectedCategory = category);
                },
                labelStyle: TextStyle(
                  color: selected ? Colors.white : const Color(0xFF536359),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
                selectedColor: const Color(0xFF174B3A),
                backgroundColor: Colors.white,
                side: BorderSide(
                  color: selected
                      ? const Color(0xFF174B3A)
                      : const Color(0xFFE6E9E3),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 64),
      child: Column(
        children: [
          const Icon(
            Icons.search_off_rounded,
            size: 42,
            color: Color(0xFF9AA69B),
          ),
          const SizedBox(height: 12),
          const Text(
            'No products found',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _searchQuery = '';
                _selectedCategory = 'All';
                _selectedOccasion = 'All';
              });
            },
            child: const Text('Clear filters'),
          ),
        ],
      ),
    );
  }

  Future<void> _showSearch() async {
    final controller = TextEditingController(text: _searchQuery);
    final query = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search products'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Try “journal” or “gifting”',
            prefixIcon: Icon(Icons.search_rounded),
          ),
          onSubmitted: (value) => Navigator.pop(context, value),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Search'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (query != null) {
      setState(() => _searchQuery = query);
    }
  }

  void _showProductDetails(BuildContext context, Product product) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ProductDetailsSheet(product: product),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({
    required this.product,
    required this.selectedOccasion,
    required this.onTap,
  });

  final Product product;
  final String selectedOccasion;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 190,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _ImagePlaceholder(icon: product.icon),
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.94),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        product.category,
                        style: const TextStyle(
                          color: Color(0xFF315B40),
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 12,
                    bottom: 12,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.94),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        product.icon,
                        color: const Color(0xFF315B40),
                        size: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 13, 15, 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF23372B),
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF748077),
                        fontSize: 11.5,
                        height: 1.4,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            product.price,
                            style: const TextStyle(
                              color: Color(0xFF174B3A),
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          color: Color(0xFF69806F),
                          size: 18,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'For ${[if (selectedOccasion != 'All') selectedOccasion, ...product.occasions.where((occasion) => occasion != selectedOccasion).take(selectedOccasion == 'All' ? 2 : 1)].join(' · ')}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF8A948C),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductDetailsSheet extends StatelessWidget {
  const _ProductDetailsSheet({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.78,
      minChildSize: 0.55,
      maxChildSize: 0.94,
      expand: false,
      builder: (context, scrollController) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF9FAF6),
          borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
        ),
        child: ListView(
          controller: scrollController,
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 260,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _ImagePlaceholder(icon: product.icon),
                  ),
                  Positioned(
                    top: 14,
                    right: 16,
                    child: IconButton.filledTonal(
                      tooltip: 'Close',
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close_rounded),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white.withValues(alpha: 0.92),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 20, 22, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.category.toUpperCase(),
                    style: const TextStyle(
                      color: Color(0xFF52805D),
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    product.name,
                    style: const TextStyle(
                      color: Color(0xFF20382B),
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 9),
                  Text(
                    product.description,
                    style: const TextStyle(
                      color: Color(0xFF657269),
                      fontSize: 14,
                      height: 1.55,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F0E7),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.sell_outlined,
                          color: Color(0xFF315B40),
                          size: 19,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          product.price,
                          style: const TextStyle(
                            color: Color(0xFF214A34),
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  const _DetailHeading(
                    icon: Icons.celebration_outlined,
                    title: 'Perfect for',
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: product.occasions
                        .map(
                          (occasion) => Chip(
                            label: Text(occasion),
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Color(0xFFE4E9E2)),
                            labelStyle: const TextStyle(
                              color: Color(0xFF536359),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 18),
                  const _DetailHeading(
                    icon: Icons.auto_awesome_outlined,
                    title: 'Make it yours',
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.customisation,
                    style: const TextStyle(
                      color: Color(0xFF657269),
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailHeading extends StatelessWidget {
  const _DetailHeading({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF477253)),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF263B2E),
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE7EEE5),
      child: Icon(icon, size: 46, color: const Color(0xFF719078)),
    );
  }
}
