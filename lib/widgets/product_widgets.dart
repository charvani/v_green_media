import 'package:flutter/material.dart';

import '../data/products.dart';
import '../screens/enquiry_form_page.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
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

class ProductDetailsSheet extends StatelessWidget {
  const ProductDetailsSheet({super.key, required this.product});

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
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: product.customisationOptions
                        .map(
                          (option) => Chip(
                            avatar: const Icon(
                              Icons.check_circle_outline_rounded,
                              size: 16,
                              color: Color(0xFF477253),
                            ),
                            label: Text(option),
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
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {
                        final navigator = Navigator.of(context);
                        navigator.pop();
                        navigator.push(
                          MaterialPageRoute<void>(
                            builder: (context) =>
                                EnquiryFormPage(initialProduct: product),
                          ),
                        );
                      },
                      icon: const Icon(Icons.mail_outline_rounded),
                      label: const Text('Enquire about this product'),
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
