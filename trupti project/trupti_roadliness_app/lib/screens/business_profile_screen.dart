// lib/screens/business_profile_screen.dart
import 'package:flutter/material.dart';
import '../models/BusinessProfile.dart';
import '../services/database_service.dart';

class BusinessProfileScreen extends StatefulWidget {
  const BusinessProfileScreen({super.key});

  @override
  State<BusinessProfileScreen> createState() => _BusinessProfileScreenState();
}

class _BusinessProfileScreenState extends State<BusinessProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseService _databaseService = DatabaseService();

  // Controllers for text fields
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _gstController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _accountNoController = TextEditingController();
  final TextEditingController _ifscController = TextEditingController();

  bool _isLoading = true;
  BusinessProfile? _currentProfile; // To hold the current business profile

  @override
  void initState() {
    super.initState();
    _loadBusinessProfile();
  }

  // Loads the existing business profile from the database.
  Future<void> _loadBusinessProfile() async {
    _currentProfile = await _databaseService.getBusinessProfile();
    if (_currentProfile != null) {
      // Populate fields with existing profile data.
      _companyNameController.text = _currentProfile!.companyName;
      _addressController.text = _currentProfile!.address;
      _emailController.text = _currentProfile!.email;
      _phoneController.text = _currentProfile!.phone;
      _panController.text = _currentProfile!.pan;
      _gstController.text = _currentProfile!.gst;
      _bankNameController.text = _currentProfile!.bankName;
      _accountNoController.text = _currentProfile!.accountNo;
      _ifscController.text = _currentProfile!.ifsc;
    }
    setState(() {
      _isLoading = false;
    });
  }

  // Handles saving the business profile.
  Future<void> _saveBusinessProfile() async {
    if (_formKey.currentState!.validate()) {
      final newProfile = BusinessProfile(
        companyName: _companyNameController.text,
        address: _addressController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        pan: _panController.text,
        gst: _gstController.text,
        bankName: _bankNameController.text,
        accountNo: _accountNoController.text,
        ifsc: _ifscController.text,
      );

      if (_currentProfile == null) {
        await _databaseService.insertBusinessProfile(newProfile);
        print('Business profile created successfully!');
      } else {
        await _databaseService.updateBusinessProfile(newProfile);
        print('Business profile updated successfully!');
      }

      if (mounted) {
        Navigator.pop(context, true); // Pop back to previous screen.
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _panController.dispose();
    _gstController.dispose();
    _bankNameController.dispose();
    _accountNoController.dispose();
    _ifscController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Business Profile')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveBusinessProfile,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _companyNameController,
                decoration: const InputDecoration(labelText: 'Company Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter company name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                    return 'Please enter a valid 10-digit phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _panController,
                decoration: const InputDecoration(labelText: 'PAN'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter PAN';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _gstController,
                decoration: const InputDecoration(labelText: 'GST'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter GST';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bankNameController,
                decoration: const InputDecoration(labelText: 'Bank Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter bank name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _accountNoController,
                decoration: const InputDecoration(labelText: 'Account Number'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter account number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ifscController,
                decoration: const InputDecoration(labelText: 'IFSC Code'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter IFSC code';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _saveBusinessProfile,
                  icon: const Icon(Icons.save),
                  label: Text(_currentProfile == null ? 'Save Profile' : 'Update Profile'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
