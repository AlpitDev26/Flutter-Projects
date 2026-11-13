// lib/screens/create_edit_client_screen.dart
import 'package:flutter/material.dart';
import '../models/client.dart';
import '../services/database_service.dart';

class CreateEditClientScreen extends StatefulWidget {
  final int? clientId; // Null for new client, ID for editing existing.

  const CreateEditClientScreen({super.key, this.clientId});

  @override
  State<CreateEditClientScreen> createState() => _CreateEditClientScreenState();
}

class _CreateEditClientScreenState extends State<CreateEditClientScreen> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseService _databaseService = DatabaseService();

  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _isLoading = true;
  Client? _existingClient; // To hold existing client data if editing

  @override
  void initState() {
    super.initState();
    _loadClientData();
  }

  // Loads existing client data if editing.
  Future<void> _loadClientData() async {
    if (widget.clientId != null) {
      _existingClient = await _databaseService.getClientById(widget.clientId!);
      if (_existingClient != null) {
        // Populate fields with existing client data.
        _nameController.text = _existingClient!.name;
        _addressController.text = _existingClient!.address;
        _emailController.text = _existingClient!.email;
        _phoneController.text = _existingClient!.phone;
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  // Handles saving the client.
  Future<void> _saveClient() async {
    if (_formKey.currentState!.validate()) {
      final newClient = Client(
        id: _existingClient?.id, // Pass existing ID if updating
        name: _nameController.text,
        address: _addressController.text,
        email: _emailController.text,
        phone: _phoneController.text,
      );

      if (widget.clientId == null) {
        await _databaseService.insertClient(newClient);
        print('Client created successfully!');
      } else {
        await _databaseService.updateClient(newClient);
        print('Client updated successfully!');
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
    _nameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.clientId == null ? 'New Client' : 'Edit Client')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.clientId == null ? 'New Client' : 'Edit Client'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveClient,
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
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Client Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter client name';
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
                  if (!RegExp(r'^\d{10}$').hasMatch(value)) { // Basic 10-digit phone number validation
                    return 'Please enter a valid 10-digit phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _saveClient,
                  icon: const Icon(Icons.save),
                  label: Text(widget.clientId == null ? 'Save Client' : 'Update Client'),
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
