import 'package:flutter/material.dart';

const occasions = [
  'Employee Onboarding',
  'Corporate Diwali Gifting',
  'New Year Gifts',
  'Client and Vendor Gifting',
  'Events and Trade Shows',
  'Employee Recognition',
];

class Product {
  const Product({
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.description,
    required this.price,
    required this.minimumPrice,
    required this.maximumPrice,
    required this.occasions,
    required this.customisation,
    required this.customisationOptions,
    required this.icon,
  });

  final String name;
  final String imageUrl;
  final String category;
  final String description;
  final String price;
  final int minimumPrice;
  final int maximumPrice;
  final List<String> occasions;
  final String customisation;
  final List<String> customisationOptions;
  final IconData icon;
}

class BudgetBand {
  const BudgetBand({
    required this.label,
    required this.minimumPrice,
    this.maximumPrice,
  });

  final String label;
  final int minimumPrice;
  final int? maximumPrice;

  bool includesPriceRange(Product product) =>
      product.maximumPrice >= minimumPrice &&
      (maximumPrice == null || product.minimumPrice <= maximumPrice!);
}

const budgetBands = [
  BudgetBand(label: 'Under ₹500', minimumPrice: 0, maximumPrice: 499),
  BudgetBand(label: '₹500 to ₹1,500', minimumPrice: 500, maximumPrice: 1500),
  BudgetBand(label: '₹1,500 to ₹3,000', minimumPrice: 1500, maximumPrice: 3000),
  BudgetBand(label: 'Above ₹3,000', minimumPrice: 3001),
];

const products = [
  Product(
    name: 'Plantable Seed Cards',
    imageUrl:
        'https://images.unsplash.com/photo-1455390582262-044cmaa2d6d8?auto=format&fit=crop&w=900&q=85',
    category: 'Paper goods',
    description:
        'Thoughtful handmade cards embedded with seeds that grow into a little patch of wildflowers.',
    price: '₹35–₹75 / card',
    minimumPrice: 35,
    maximumPrice: 75,
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
    customisationOptions: ['Logo printing', 'Name personalisation'],
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
    minimumPrice: 249,
    maximumPrice: 499,
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
    customisationOptions: ['Logo printing', 'Name personalisation'],
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
    minimumPrice: 399,
    maximumPrice: 799,
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
    customisationOptions: ['Laser engraving', 'Name personalisation'],
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
    minimumPrice: 599,
    maximumPrice: 1099,
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
    customisationOptions: [
      'Logo printing',
      'Laser engraving',
      'Name personalisation',
    ],
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
    minimumPrice: 199,
    maximumPrice: 449,
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
    customisationOptions: ['Logo printing', 'Name personalisation'],
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
    minimumPrice: 299,
    maximumPrice: 649,
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
    customisationOptions: [
      'Logo printing',
      'Laser engraving',
      'Name personalisation',
    ],
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
    minimumPrice: 349,
    maximumPrice: 699,
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
    customisationOptions: ['Logo printing', 'Name personalisation'],
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
    minimumPrice: 899,
    maximumPrice: 2499,
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
    customisationOptions: ['Logo printing', 'Name personalisation'],
    icon: Icons.redeem_outlined,
  ),
];
