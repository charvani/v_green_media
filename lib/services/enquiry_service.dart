import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../data/enquiry.dart';

class EnquiryService {
  EnquiryService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Future<String> createEnquiry(Enquiry enquiry) async {
    final document = await _firestore
        .collection('enquiries')
        .add(toFirestoreData(enquiry));
    return document.id;
  }

  static Map<String, Object> toFirestoreData(Enquiry enquiry) => {
    'budget_per_unit': enquiry.budgetPerUnit,
    'company': enquiry.company,
    'customisation_needed': enquiry.customisations,
    'delivery_date': Timestamp.fromDate(enquiry.deliveryDate),
    'email': enquiry.email,
    'enquiry_from': kIsWeb ? 'web' : 'mobile',
    'message': enquiry.message,
    'name': enquiry.name,
    'number_of_units': enquiry.units,
    'occasion': enquiry.occasion,
    'other_info': enquiry.otherCustomisation,
    'phone': enquiry.phone,
    'products_selected': enquiry.products,
  };
}
