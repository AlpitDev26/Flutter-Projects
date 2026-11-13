// lib/screens/create_edit_invoice_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import '../models/client.dart';
import '../models/invoice.dart';
import '../models/InvoiceItems.dart';
import '../services/database_service.dart';

class CreateEditInvoiceScreen extends StatefulWidget {
  final int? invoiceId; // Null for new invoice, ID for editing existing.

  const CreateEditInvoiceScreen({super.key, this.invoiceId});

  @override
  State<CreateEditInvoiceScreen> createState() => _CreateEditInvoiceScreenState();
}

class _CreateEditInvoiceScreenState extends State<CreateEditInvoiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseService _databaseService = DatabaseService();

  // Controllers for text fields
  final TextEditingController _invoiceNoController = TextEditingController();
  final TextEditingController _invoiceDateController = TextEditingController();
  final TextEditingController _amountInWordsController = TextEditingController();
  final TextEditingController _bankDetailsController = TextEditingController();
  final TextEditingController _paymentNoteController = TextEditingController();

  List<Client> _clients = []; // List of available clients
  Client? _selectedClient; // Currently selected client
  List<InvoiceItem> _invoiceItems = []; // List of items in the current invoice
  double _totalAmount = 0.0; // Calculated total amount

  bool _isLoading = true;
  Invoice? _existingInvoice; // To hold existing invoice data if editing

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Loads clients and, if editing, the existing invoice data.
  Future<void> _loadData() async {
    _clients = await _databaseService.getClients();

    if (widget.invoiceId != null) {
      _existingInvoice = await _databaseService.getInvoiceById(widget.invoiceId!);
      if (_existingInvoice != null) {
        // Populate fields with existing invoice data.
        _invoiceNoController.text = _existingInvoice!.invoiceNo;
        _invoiceDateController.text = _existingInvoice!.invoiceDate;
        _selectedClient = _clients.firstWhere(
          (client) => client.id == _existingInvoice!.client.id,
          orElse: () => _clients.first, // Fallback if client not found
        );
        _invoiceItems = List.from(_existingInvoice!.items); // Create a mutable copy
        _amountInWordsController.text = _existingInvoice!.amountInWords;
        _bankDetailsController.text = _existingInvoice!.bankDetails;
        _paymentNoteController.text = _existingInvoice!.paymentNote;
        _calculateTotalAmount();
      }
    } else {
      // For new invoice, set default date to today.
      _invoiceDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
      if (_clients.isNotEmpty) {
        _selectedClient = _clients.first; // Select first client by default
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  // Calculates the total amount from invoice items.
  void _calculateTotalAmount() {
    double sum = 0.0;
    for (var item in _invoiceItems) {
      sum += item.amount;
    }
    setState(() {
      _totalAmount = sum;
      // You might want to integrate an amount-to-words conversion here.
      // For simplicity, we'll leave it as a manual input for now.
    });
  }

  // Shows a date picker for the invoice date.
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(_invoiceDateController.text) ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _invoiceDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  // Shows a dialog to add/edit an invoice item.
  Future<void> _showInvoiceItemDialog({InvoiceItem? item, int? index}) async {
    final TextEditingController particularsController = TextEditingController(text: item?.particulars ?? '');
    final TextEditingController vehicleNoController = TextEditingController(text: item?.vehicleNo ?? '');
    final TextEditingController pkgController = TextEditingController(text: item?.pkg ?? '');
    final TextEditingController amountController = TextEditingController(text: item?.amount.toString() ?? '');

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text(item == null ? 'Add Item' : 'Edit Item'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: particularsController,
                  decoration: const InputDecoration(labelText: 'Particulars'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Particulars cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: vehicleNoController,
                  decoration: const InputDecoration(labelText: 'Vehicle No (Optional)'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: pkgController,
                  decoration: const InputDecoration(labelText: 'Package (Optional)'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: amountController,
                  decoration: const InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Amount cannot be empty';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Enter a valid number';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (particularsController.text.isNotEmpty &&
                    amountController.text.isNotEmpty &&
                    double.tryParse(amountController.text) != null) {
                  final newItem = InvoiceItem(
                    particulars: particularsController.text,
                    vehicleNo: vehicleNoController.text,
                    pkg: pkgController.text,
                    amount: double.parse(amountController.text),
                  );
                  setState(() {
                    if (index == null) {
                      _invoiceItems.add(newItem); // Add new item
                    } else {
                      _invoiceItems[index] = newItem; // Update existing item
                    }
                    _calculateTotalAmount();
                  });
                  Navigator.pop(context);
                }
              },
              child: Text(item == null ? 'Add' : 'Update'),
            ),
          ],
        );
      },
    );
  }

  // Handles saving the invoice.
  Future<void> _saveInvoice() async {
    if (_formKey.currentState!.validate() && _selectedClient != null && _invoiceItems.isNotEmpty) {
      final newInvoice = Invoice(
        id: _existingInvoice?.invoiceNo, // Pass existing ID if updating
        invoiceNo: _invoiceNoController.text,
        invoiceDate: _invoiceDateController.text,
        client: _selectedClient!,
        items: _invoiceItems,
        totalAmount: _totalAmount,
        amountInWords: _amountInWordsController.text,
        bankDetails: _bankDetailsController.text,
        paymentNote: _paymentNoteController.text,
      );

      if (widget.invoiceId == null) {
        await _databaseService.insertInvoice(newInvoice);
        print('Invoice created successfully!');
      } else {
        await _databaseService.updateInvoice(newInvoice);
        print('Invoice updated successfully!');
      }

      if (mounted) {
        Navigator.pop(context, true); // Pop back to previous screen.
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields, select a client, and add at least one item.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _invoiceNoController.dispose();
    _invoiceDateController.dispose();
    _amountInWordsController.dispose();
    _bankDetailsController.dispose();
    _paymentNoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.invoiceId == null ? 'New Invoice' : 'Edit Invoice')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.invoiceId == null ? 'New Invoice' : 'Edit Invoice'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveInvoice,
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
              // Invoice Number and Date
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _invoiceNoController,
                      decoration: const InputDecoration(labelText: 'Invoice No.'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter invoice number';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _invoiceDateController,
                      decoration: InputDecoration(
                        labelText: 'Invoice Date',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(context),
                        ),
                      ),
                      readOnly: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select invoice date';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Client Selection
              _buildSectionTitle('Client Details'),
              if (_clients.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      const Text('No clients available. Please add a client first.'),
                      TextButton.icon(
                        onPressed: () async {
                          await Navigator.pushNamed(context, '/create_edit_client');
                          _loadData(); // Reload clients after adding a new one
                        },
                        icon: const Icon(Icons.person_add),
                        label: const Text('Add New Client'),
                      ),
                    ],
                  ),
                )
              else
                DropdownButtonFormField<Client>(
                  value: _selectedClient,
                  decoration: const InputDecoration(labelText: 'Select Client'),
                  items: _clients.map((client) {
                    return DropdownMenuItem(
                      value: client,
                      child: Text(client.name),
                    );
                  }).toList(),
                  onChanged: (Client? newValue) {
                    setState(() {
                      _selectedClient = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a client';
                    }
                    return null;
                  },
                ),
              const SizedBox(height: 20),

              // Invoice Items
              _buildSectionTitle('Invoice Items'),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _invoiceItems.length,
                itemBuilder: (context, index) {
                  final item = _invoiceItems[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      title: Text(item.particulars),
                      subtitle: Text('Amount: ₹${item.amount.toStringAsFixed(2)}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _showInvoiceItemDialog(item: item, index: index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                _invoiceItems.removeAt(index);
                                _calculateTotalAmount();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () => _showInvoiceItemDialog(),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Item'),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Total Amount: ₹${_totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ),
              const SizedBox(height: 20),

              // Amount in Words
              TextFormField(
                controller: _amountInWordsController,
                decoration: const InputDecoration(labelText: 'Amount in Words'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter amount in words';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Bank Details
              TextFormField(
                controller: _bankDetailsController,
                decoration: const InputDecoration(labelText: 'Bank Details'),
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter bank details';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Payment Note
              TextFormField(
                controller: _paymentNoteController,
                decoration: const InputDecoration(labelText: 'Payment Note'),
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter payment note';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              Center(
                child: ElevatedButton.icon(
                  onPressed: _saveInvoice,
                  icon: const Icon(Icons.save),
                  label: Text(widget.invoiceId == null ? 'Save Invoice' : 'Update Invoice'),
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

  // Helper widget to build section titles.
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
      ),
    );
  }
}
