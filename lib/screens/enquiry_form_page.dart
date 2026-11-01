import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/enquiry.dart';
import '../data/products.dart';
import '../services/enquiry_service.dart';
import '../services/page_metadata.dart';
import 'thank_you_page.dart';

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
  final _nameFieldKey = GlobalKey<FormFieldState<String>>();
  final _companyFieldKey = GlobalKey<FormFieldState<String>>();
  final _phoneFieldKey = GlobalKey<FormFieldState<String>>();
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
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    setPageMetadata(
      title: 'Product Enquiry | V Green Media',
      description:
          'Tell V Green Media about your sustainable gifting requirements '
          'and request a custom product enquiry.',
      imageUrl:
          'https://images.unsplash.com/photo-1490750967868-88aa4486c946?auto=format&fit=crop&w=1200&h=630&q=85',
    );
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
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                fieldKey: _nameFieldKey,
                validator: (value) => _required(value, 'Enter your name'),
                textCapitalization: TextCapitalization.words,
                autofillHints: const [AutofillHints.name],
              ),
              _field(
                label: 'Company',
                controller: _companyController,
                fieldKey: _companyFieldKey,
                validator: (value) =>
                    _required(value, 'Enter your company name'),
                textCapitalization: TextCapitalization.words,
                autofillHints: const [AutofillHints.organizationName],
              ),
              _field(
                label: 'Phone',
                controller: _phoneController,
                fieldKey: _phoneFieldKey,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                autofillHints: const [AutofillHints.telephoneNumber],
                validator: (value) {
                  final digits = value?.trim() ?? '';
                  if (digits.isEmpty) return 'Enter your phone number';
                  return digits.length != 10
                      ? 'Enter a valid phone number'
                      : null;
                },
              ),
              _field(
                label: 'Email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                enableSuggestions: false,
                autofillHints: const [AutofillHints.email],
                validator: (value) {
                  final email = value?.trim() ?? '';
                  return RegExp(
                        r"^[A-Za-z0-9.!#$%&'*+/=?^_`{|}~-]+@"
                        r"[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?"
                        r"(?:\.[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?)+$",
                      ).hasMatch(email)
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
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                inputFormatters: [
                  TextInputFormatter.withFunction((oldValue, newValue) {
                    return RegExp(r'^\d*\.?\d{0,2}$').hasMatch(newValue.text)
                        ? newValue
                        : oldValue;
                  }),
                ],
                prefixText: '₹ ',
                validator: (value) {
                  final budget = double.tryParse(value?.trim() ?? '');
                  return budget == null || !budget.isFinite || budget <= 0
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
                textCapitalization: TextCapitalization.sentences,
              ),
              _field(
                label: 'Message (optional)',
                controller: _messageController,
                maxLines: 4,
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 50,
                child: FilledButton.icon(
                  onPressed: _isSubmitting ? null : _submit,
                  icon: _isSubmitting
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.send_outlined),
                  label: Text(
                    _isSubmitting ? 'Submitting...' : 'Submit enquiry',
                  ),
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
    List<TextInputFormatter>? inputFormatters,
    Iterable<String>? autofillHints,
    bool autocorrect = true,
    bool enableSuggestions = true,
    GlobalKey<FormFieldState<String>>? fieldKey,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        key: fieldKey,
        controller: controller,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        textInputAction: maxLines == 1
            ? TextInputAction.next
            : TextInputAction.newline,
        inputFormatters: inputFormatters,
        autofillHints: autofillHints,
        autocorrect: autocorrect,
        enableSuggestions: enableSuggestions,
        maxLines: maxLines,
        onTap: fieldKey == null
            ? null
            : () => fieldKey.currentState?.validate(),
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

  Future<void> _submit() async {
    if (_isSubmitting) return;
    final isValid = _formKey.currentState!.validate();
    setState(() => _showProductsError = _selectedProducts.isEmpty);
    if (!isValid || _selectedProducts.isEmpty) return;

    final submittedAt = DateTime.now();
    final enquiry = Enquiry(
      id: submittedAt.microsecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      company: _companyController.text.trim(),
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      occasion: _selectedOccasion!,
      units: int.parse(_unitsController.text.trim()),
      budgetPerUnit: double.parse(_budgetController.text.trim()),
      deliveryDate: _deliveryDate!,
      products: _selectedProducts.map((product) => product.name).toList(),
      customisations: _selectedCustomisations.toList(),
      otherCustomisation: _otherCustomisationController.text.trim(),
      message: _messageController.text.trim(),
      submittedAt: submittedAt,
      submittedFrom: kIsWeb ? EnquirySource.web : EnquirySource.mobile,
    );
    setState(() => _isSubmitting = true);
    try {
      await EnquiryService().createEnquiry(enquiry);
    } on FirebaseException catch (error) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Could not submit your enquiry (${error.code}): ${error.message ?? 'Please try again.'}',
          ),
        ),
      );
      return;
    } catch (error) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not submit your enquiry: $error')),
      );
      return;
    }
    if (!mounted) return;

    String? localSaveError;
    try {
      await EnquiryStore().save(enquiry);
    } catch (error) {
      localSaveError = error.toString();
    }
    if (!mounted) return;
    setState(() => _isSubmitting = false);

    await Navigator.of(context).pushReplacement<void, void>(
      MaterialPageRoute<void>(
        builder: (context) => ThankYouPage(localSaveError: localSaveError),
      ),
    );
  }
}
