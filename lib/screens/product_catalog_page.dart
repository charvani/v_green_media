import 'package:flutter/material.dart';

import '../data/products.dart';
import '../services/page_metadata.dart';
import '../widgets/product_widgets.dart';
import 'enquiry_form_page.dart';
import 'my_enquiries_page.dart';

class ProductCatalogPage extends StatefulWidget {
  const ProductCatalogPage({super.key});

  @override
  State<ProductCatalogPage> createState() => _ProductCatalogPageState();
}

class _ProductCatalogPageState extends State<ProductCatalogPage> {
  String _selectedCategory = 'All';
  String _selectedOccasion = 'All';
  BudgetBand? _selectedBudgetBand;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _setCatalogMetadata();
  }

  void _setCatalogMetadata() {
    setPageMetadata(
      title: 'V Green Media | Thoughtful Sustainable Gifts',
      description:
          'Discover thoughtful, customisable sustainable gifts for teams, '
          'clients, and special occasions.',
      imageUrl:
          'https://images.unsplash.com/photo-1490750967868-88aa4486c946?auto=format&fit=crop&w=1200&h=630&q=85',
    );
  }

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
      final matchesBudget =
          _selectedBudgetBand == null ||
          _selectedBudgetBand!.includesPriceRange(product);
      final matchesSearch =
          query.isEmpty ||
          product.name.toLowerCase().contains(query) ||
          product.description.toLowerCase().contains(query) ||
          product.category.toLowerCase().contains(query) ||
          product.occasions.any(
            (occasion) => occasion.toLowerCase().contains(query),
          );
      return matchesCategory &&
          matchesOccasion &&
          matchesBudget &&
          matchesSearch;
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
                        (context, index) => ProductCard(
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
                'V GREEN MEDIA',
                style: TextStyle(
                  color: Color(0xFF174B3A),
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),
              Text(
                'MEMORABLE & MEANINGFUL GIFTS',
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
            tooltip: 'My enquiries',
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const MyEnquiriesPage(),
                ),
              );
              if (mounted) _setCatalogMetadata();
            },
            icon: const Icon(Icons.receipt_long_outlined),
          ),
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
          FilledButton.icon(
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const EnquiryFormPage(),
                ),
              );
              if (mounted) _setCatalogMetadata();
            },
            icon: const Icon(Icons.mail_outline_rounded, size: 18),
            label: const Text('Make an enquiry'),
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
              // const Icon(
              //   Icons.tune_rounded,
              //   size: 16,
              //   color: Color(0xFF4E7859),
              // ),
              // const SizedBox(width: 6),
              // const Text(
              //   'Made personal',
              //   style: TextStyle(
              //     color: Color(0xFF315B40),
              //     fontSize: 12,
              //     fontWeight: FontWeight.w700,
              //   ),
              // ),
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
            'Shop by budget',
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
            itemCount: budgetBands.length + 1,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final band = index == 0 ? null : budgetBands[index - 1];
              final selected = band == _selectedBudgetBand;
              return ChoiceChip(
                label: Text(band?.label ?? 'All budgets'),
                selected: selected,
                showCheckmark: false,
                onSelected: (value) {
                  setState(() => _selectedBudgetBand = band);
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
                _selectedBudgetBand = null;
              });
            },
            child: const Text('Clear filters'),
          ),
        ],
      ),
    );
  }

  Future<void> _showSearch() async {
    final query = await showDialog<String>(
      context: context,
      builder: (context) => _ProductSearchDialog(initialQuery: _searchQuery),
    );
    if (query != null && mounted) {
      setState(() => _searchQuery = query);
    }
  }

  void _showProductDetails(BuildContext context, Product product) {
    final catalogRoute = ModalRoute.of(context);
    setPageMetadata(
      title: '${product.name} | V Green Media',
      description: product.description,
      imageUrl: product.imageUrl,
    );
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ProductDetailsSheet(product: product),
    ).whenComplete(() {
      if (mounted && catalogRoute?.isCurrent == true) {
        _setCatalogMetadata();
      }
    });
  }
}

class _ProductSearchDialog extends StatefulWidget {
  const _ProductSearchDialog({required this.initialQuery});

  final String initialQuery;

  @override
  State<_ProductSearchDialog> createState() => _ProductSearchDialogState();
}

class _ProductSearchDialogState extends State<_ProductSearchDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuery);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Search products'),
      content: TextField(
        controller: _controller,
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
          onPressed: () => Navigator.pop(context, _controller.text),
          child: const Text('Search'),
        ),
      ],
    );
  }
}
