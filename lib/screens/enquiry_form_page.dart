import 'package:flutter/material.dart';

import '../data/products.dart';

class EnquiryFormPage extends StatefulWidget {
  const EnquiryFormPage({super.key, this.initialProduct});

  final Product? initialProduct;

  @override
  State<EnquiryFormPage> createState() => _EnquiryFormPageState();
}

class _EnquiryFormPageState extends State<EnquiryFormPage> {
  static const _customisationOptions = [
    'Logo printing',
    'Laser engraving',
    'Name personalisation',
  ];

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _companyController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _unitsController = TextEditingController();
  final _budgetController = TextEditingController();
  final _messageController = TextEditingController();
  final _otherCustomisationController = TextEditingController();
  final Set<Product> _selectedProducts = {};
  final Set<String> _selectedCustomisations = {};
  String? _selectedOccasion;
  DateTime? _deliveryDate;
  bool _showProductsError = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialProduct case final product?) {
      _selectedProducts.add(product);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _companyController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _unitsController.dispose();
    _budgetController.dispose();
    _messageController.dispose();
    _otherCustomisationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product enquiry')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(22, 12, 22, 32),
            children: [
              const Text(
                'Tell us what you need',
                style: TextStyle(
                  color: Color(0xFF20382B),
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Share a few details and we’ll help plan your gifting order.',
                style: TextStyle(color: Color(0xFF657269), height: 1.5),
              ),
              const SizedBox(height: 24),
              _field(
                label: 'Name',
                controller: _nameController,
                validator: (value) => _required(value, 'Enter your name'),
                textCapitalization: TextCapitalization.words,
              ),
              _field(
                label: 'Company',
                controller: _companyController,
                textCapitalization: TextCapitalization.words,
              ),
              _field(
                label: 'Phone',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  final digits = value?.replaceAll(RegExp(r'\D'), '') ?? '';
                  return digits.length < 10 || digits.length > 15
                      ? 'Enter a valid phone number'
                      : null;
                },
              ),
              _field(
                label: 'Email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  final email = value?.trim() ?? '';
                  return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)
                      ? null
                      : 'Enter a valid email address';
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedOccasion,
                decoration: _decoration('Occasion'),
                items: occasions
                    .map(
                      (occasion) => DropdownMenuItem(
                        value: occasion,
                        child: Text(occasion),
                      ),
                    )
                    .toList(),
                onChanged: (value) => setState(() => _selectedOccasion = value),
                validator: (value) =>
                    value == null ? 'Select an occasion' : null,
              ),
              const SizedBox(height: 16),
              _field(
                label: 'Number of units',
                controller: _unitsController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  final units = int.tryParse(value?.trim() ?? '');
                  return units == null || units < 1
                      ? 'Enter at least 1 unit'
                      : null;
                },
              ),
              _field(
                label: 'Budget per unit',
                controller: _budgetController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                prefixText: '₹ ',
                validator: (value) {
                  final budget = double.tryParse(value?.trim() ?? '');
                  return budget == null || budget <= 0
                      ? 'Enter a valid budget per unit'
                      : null;
                },
              ),
              FormField<DateTime>(
                initialValue: _deliveryDate,
                validator: (value) =>
                    value == null ? 'Select a delivery date' : null,
                builder: (field) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () => _pickDeliveryDate(field),
                      child: InputDecorator(
                        decoration: _decoration('Delivery date').copyWith(
                          suffixIcon: const Icon(Icons.calendar_today_outlined),
                          errorText: field.errorText,
                        ),
                        child: Text(
                          _deliveryDate == null
                              ? 'Choose a delivery date'
                              : _formatDate(_deliveryDate!),
                          style: TextStyle(
                            color: _deliveryDate == null
                                ? const Color(0xFF7C877E)
                                : const Color(0xFF20352A),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _sectionHeading('Products selected'),
              const SizedBox(height: 6),
              const Text(
                'Select one or more products.',
                style: TextStyle(color: Color(0xFF657269), fontSize: 12),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: products
                    .map(
                      (product) => FilterChip(
                        label: Text(product.name),
                        selected: _selectedProducts.contains(product),
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedProducts.add(product);
                            } else {
                              _selectedProducts.remove(product);
                            }
                            _showProductsError = false;
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
              if (_showProductsError)
                const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    'Select at least one product',
                    style: TextStyle(color: Color(0xFFB3261E), fontSize: 12),
                  ),
                ),
              const SizedBox(height: 24),
              _sectionHeading('Customisation needed'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: _customisationOptions
                    .map(
                      (option) => FilterChip(
                        label: Text(option),
                        selected: _selectedCustomisations.contains(option),
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedCustomisations.add(option);
                            } else {
                              _selectedCustomisations.remove(option);
                            }
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 8),
              _field(
                label: 'Other customisation details (optional)',
                controller: _otherCustomisationController,
                maxLines: 2,
              ),
              _field(
                label: 'Message (optional)',
                controller: _messageController,
                maxLines: 4,
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 50,
                child: FilledButton.icon(
                  onPressed: _submit,
                  icon: const Icon(Icons.send_outlined),
                  label: const Text('Submit enquiry'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    String? prefixText,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        maxLines: maxLines,
        validator: validator,
        decoration: _decoration(label).copyWith(prefixText: prefixText),
      ),
    );
  }

  InputDecoration _decoration(String label) => InputDecoration(
    labelText: label,
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0xFFE4E9E2)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0xFFE4E9E2)),
    ),
  );

  Widget _sectionHeading(String title) => Text(
    title,
    style: const TextStyle(
      color: Color(0xFF20352A),
      fontSize: 15,
      fontWeight: FontWeight.w800,
    ),
  );

  String? _required(String? value, String error) =>
      value == null || value.trim().isEmpty ? error : null;

  Future<void> _pickDeliveryDate(FormFieldState<DateTime> field) async {
    final today = DateUtils.dateOnly(DateTime.now());
    final picked = await showDatePicker(
      context: context,
      initialDate: _deliveryDate ?? today,
      firstDate: today,
      lastDate: DateTime(today.year + 5),
    );
    if (picked != null) {
      field.didChange(picked);
      setState(() => _deliveryDate = picked);
    }
  }

  String _formatDate(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}/${date.year}';

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    setState(() => _showProductsError = _selectedProducts.isEmpty);
    if (!isValid || _selectedProducts.isEmpty) return;

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enquiry details complete'),
        content: const Text(
          'Your enquiry is ready. This form is not connected to a submission service yet.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}
