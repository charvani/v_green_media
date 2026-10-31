import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/products.dart';

const _whatsAppBusinessNumber = '917207967958';

Uri productWhatsAppUri(
  Product product,
) => Uri.https('wa.me', '/$_whatsAppBusinessNumber', {
  'text':
      "Hi V Green Media, I'm interested in ${product.name}. "
      'Could you please share more details, pricing, and customisation options?',
});

Future<void> openProductWhatsAppChat(
  BuildContext context,
  Product product,
) async {
  final launched = await launchUrl(
    productWhatsAppUri(product),
    mode: LaunchMode.externalApplication,
  );
  if (!launched && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Could not open WhatsApp. Please try again.'),
      ),
    );
  }
}
