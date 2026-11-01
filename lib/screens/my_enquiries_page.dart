import 'package:flutter/material.dart';

import '../data/enquiry.dart';
import '../services/page_metadata.dart';
import 'enquiry_form_page.dart';

class MyEnquiriesPage extends StatefulWidget {
  const MyEnquiriesPage({super.key});

  @override
  State<MyEnquiriesPage> createState() => _MyEnquiriesPageState();
}

class _MyEnquiriesPageState extends State<MyEnquiriesPage> {
  final _store = EnquiryStore();
  late Future<List<Enquiry>> _enquiries;

  @override
  void initState() {
    super.initState();
    _setMetadata();
    _enquiries = _store.load();
  }

  void _setMetadata() {
    setPageMetadata(
      title: 'My Enquiries | V Green Media',
      description:
          'View your saved product enquiries for sustainable corporate gifts.',
      imageUrl:
          'https://images.unsplash.com/photo-1490750967868-88aa4486c946?auto=format&fit=crop&w=1200&h=630&q=85',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My enquiries')),
      body: SafeArea(
        child: FutureBuilder<List<Enquiry>>(
          future: _enquiries,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return _MessageState(
                icon: Icons.error_outline_rounded,
                title: 'Could not load enquiries',
                message: 'Please try again.',
                actionLabel: 'Retry',
                onAction: () => setState(() => _enquiries = _store.load()),
              );
            }

            final enquiries = snapshot.data!;
            if (enquiries.isEmpty) {
              return _MessageState(
                icon: Icons.inbox_outlined,
                title: 'No enquiries yet',
                message: 'Your submitted product enquiries will appear here.',
                actionLabel: 'Make an enquiry',
                onAction: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => const EnquiryFormPage(),
                    ),
                  );
                  if (mounted) _setMetadata();
                },
              );
            }

            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
              children: [
                // const Padding(
                //   padding: EdgeInsets.fromLTRB(2, 0, 2, 14),
                //   child: Text(
                //     '',
                //     style: TextStyle(color: Color(0xFF657269), height: 1.5),
                //   ),
                // ),
                for (final enquiry in enquiries)
                  _EnquiryCard(
                    enquiry: enquiry,
                    onTap: () => _showDetails(context, enquiry),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _showDetails(BuildContext context, Enquiry enquiry) async {
    setPageMetadata(
      title: 'Enquiry Details | V Green Media',
      description: 'Review the details of your saved product enquiry.',
      imageUrl:
          'https://images.unsplash.com/photo-1490750967868-88aa4486c946?auto=format&fit=crop&w=1200&h=630&q=85',
    );
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enquiry details'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _DetailLine('Submitted', _formatDate(enquiry.submittedAt)),
              _DetailLine('Submitted from', enquiry.submittedFrom.label),
              _DetailLine('Name', enquiry.name),
              if (enquiry.company.isNotEmpty)
                _DetailLine('Company', enquiry.company),
              _DetailLine('Phone', enquiry.phone),
              _DetailLine('Email', enquiry.email),
              _DetailLine('Occasion', enquiry.occasion),
              _DetailLine('Units', '${enquiry.units}'),
              _DetailLine(
                'Budget per unit',
                '₹${enquiry.budgetPerUnit.toStringAsFixed(2)}',
              ),
              _DetailLine('Delivery date', _formatDate(enquiry.deliveryDate)),
              _DetailLine('Products', enquiry.products.join(', ')),
              if (enquiry.customisations.isNotEmpty)
                _DetailLine('Customisation', enquiry.customisations.join(', ')),
              if (enquiry.otherCustomisation.isNotEmpty)
                _DetailLine('Other details', enquiry.otherCustomisation),
              if (enquiry.message.isNotEmpty)
                _DetailLine('Message', enquiry.message),
              const SizedBox(height: 8),
              const Text(
                'Submitted to V Green Media.',
                style: TextStyle(color: Color(0xFF657269), fontSize: 12),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
    if (mounted) _setMetadata();
  }
}

class _EnquiryCard extends StatelessWidget {
  const _EnquiryCard({required this.enquiry, required this.onTap});

  final Enquiry enquiry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.mark_email_read_outlined,
                    color: Color(0xFF315B40),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      enquiry.products.join(', '),
                      style: const TextStyle(
                        color: Color(0xFF20352A),
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                '${enquiry.occasion} · ${enquiry.units} units',
                style: const TextStyle(color: Color(0xFF536359)),
              ),
              const SizedBox(height: 6),
              Text(
                'From ${enquiry.submittedFrom.label}',
                style: const TextStyle(color: Color(0xFF536359), fontSize: 12),
              ),
              const SizedBox(height: 6),
              Text(
                'Saved ${_formatDate(enquiry.submittedAt)}',
                style: const TextStyle(color: Color(0xFF7C877E), fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailLine extends StatelessWidget {
  const _DetailLine(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 9),
    child: Text.rich(
      TextSpan(
        style: const TextStyle(color: Color(0xFF536359), height: 1.4),
        children: [
          TextSpan(
            text: '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          TextSpan(text: value),
        ],
      ),
    ),
  );
}

class _MessageState extends StatelessWidget {
  const _MessageState({
    required this.icon,
    required this.title,
    required this.message,
    required this.actionLabel,
    required this.onAction,
  });

  final IconData icon;
  final String title;
  final String message;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48, color: const Color(0xFF77917D)),
          const SizedBox(height: 14),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF20352A),
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFF657269), height: 1.5),
          ),
          const SizedBox(height: 18),
          FilledButton(onPressed: onAction, child: Text(actionLabel)),
        ],
      ),
    ),
  );
}

String _formatDate(DateTime date) =>
    '${date.day.toString().padLeft(2, '0')}/'
    '${date.month.toString().padLeft(2, '0')}/${date.year}';
