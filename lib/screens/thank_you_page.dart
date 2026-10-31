import 'package:flutter/material.dart';

import '../services/page_metadata.dart';
import 'my_enquiries_page.dart';

class ThankYouPage extends StatefulWidget {
  const ThankYouPage({super.key, this.localSaveError});

  final String? localSaveError;

  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ThankYouPage> {
  @override
  void initState() {
    super.initState();
    setPageMetadata(
      title: 'Thank You | V Green Media',
      description: 'Your product enquiry has been submitted to V Green Media.',
      imageUrl:
          'https://images.unsplash.com/photo-1490750967868-88aa4486c946?auto=format&fit=crop&w=1200&h=630&q=85',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thank you')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 88,
                    height: 88,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE2EEE4),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      size: 48,
                      color: Color(0xFF174B3A),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Thank you for your enquiry!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF20382B),
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Your enquiry has been submitted successfully. '
                    'Our team will be in touch soon.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF657269),
                      height: 1.6,
                      fontSize: 15,
                    ),
                  ),
                  if (widget.localSaveError != null) ...[
                    const SizedBox(height: 18),
                    Text(
                      'Your enquiry was submitted, but could not be saved '
                      'to this device’s enquiry history: '
                      '${widget.localSaveError}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF8A4B08),
                        height: 1.5,
                      ),
                    ),
                  ],
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () =>
                          Navigator.of(context).pushReplacement<void, void>(
                            MaterialPageRoute<void>(
                              builder: (context) => const MyEnquiriesPage(),
                            ),
                          ),
                      icon: const Icon(Icons.receipt_long_outlined),
                      label: const Text('View my enquiries'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Continue browsing'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
