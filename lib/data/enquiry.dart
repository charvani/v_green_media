import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

enum EnquirySource {
  web,
  mobile,
  unknown;

  static EnquirySource fromValue(String? value) => switch (value) {
    'web' => EnquirySource.web,
    'mobile' => EnquirySource.mobile,
    _ => EnquirySource.unknown,
  };

  String get label => switch (this) {
    EnquirySource.web => 'Web',
    EnquirySource.mobile => 'Mobile',
    EnquirySource.unknown => 'Unknown',
  };
}

class Enquiry {
  const Enquiry({
    required this.id,
    required this.name,
    required this.company,
    required this.phone,
    required this.email,
    required this.occasion,
    required this.units,
    required this.budgetPerUnit,
    required this.deliveryDate,
    required this.products,
    required this.customisations,
    required this.otherCustomisation,
    required this.message,
    required this.submittedAt,
    required this.submittedFrom,
  });

  final String id;
  final String name;
  final String company;
  final String phone;
  final String email;
  final String occasion;
  final int units;
  final double budgetPerUnit;
  final DateTime deliveryDate;
  final List<String> products;
  final List<String> customisations;
  final String otherCustomisation;
  final String message;
  final DateTime submittedAt;
  final EnquirySource submittedFrom;

  Map<String, Object> toJson() => {
    'id': id,
    'name': name,
    'company': company,
    'phone': phone,
    'email': email,
    'occasion': occasion,
    'units': units,
    'budgetPerUnit': budgetPerUnit,
    'deliveryDate': deliveryDate.toIso8601String(),
    'products': products,
    'customisations': customisations,
    'otherCustomisation': otherCustomisation,
    'message': message,
    'submittedAt': submittedAt.toIso8601String(),
    'submittedFrom': submittedFrom.name,
  };

  factory Enquiry.fromJson(Map<String, dynamic> json) => Enquiry(
    id: json['id'] as String,
    name: json['name'] as String,
    company: json['company'] as String,
    phone: json['phone'] as String,
    email: json['email'] as String,
    occasion: json['occasion'] as String,
    units: json['units'] as int,
    budgetPerUnit: (json['budgetPerUnit'] as num).toDouble(),
    deliveryDate: DateTime.parse(json['deliveryDate'] as String),
    products: (json['products'] as List<dynamic>).cast<String>(),
    customisations: (json['customisations'] as List<dynamic>).cast<String>(),
    otherCustomisation: json['otherCustomisation'] as String,
    message: json['message'] as String,
    submittedAt: DateTime.parse(json['submittedAt'] as String),
    submittedFrom: EnquirySource.fromValue(
      json['submittedFrom'] as String?,
    ),
  );
}

class EnquiryStore {
  static const _storageKey = 'saved_enquiries';

  Future<List<Enquiry>> load() async {
    final preferences = await SharedPreferences.getInstance();
    final raw = preferences.getString(_storageKey);
    if (raw == null) return [];

    final decoded = jsonDecode(raw) as List<dynamic>;
    final enquiries = decoded
        .map((item) => Enquiry.fromJson(item as Map<String, dynamic>))
        .toList();
    enquiries.sort((a, b) => b.submittedAt.compareTo(a.submittedAt));
    return enquiries;
  }

  Future<void> save(Enquiry enquiry) async {
    final enquiries = await load();
    enquiries.insert(0, enquiry);
    final preferences = await SharedPreferences.getInstance();
    final saved = await preferences.setString(
      _storageKey,
      jsonEncode(enquiries.map((item) => item.toJson()).toList()),
    );
    if (!saved) {
      throw StateError('The enquiry could not be saved to local storage.');
    }
  }
}
