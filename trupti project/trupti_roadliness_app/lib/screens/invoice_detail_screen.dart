// lib/screens/invoice_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date and number formatting
import '../models/invoice.dart';
import '../screens/home_screen.dart';
import '../models/businessProfile.dart'; // Import BusinessProfile
import '../services/database_service.dart';

class InvoiceDetailScreen extends StatefulWidget {
  final int? invoiceNo;

  const InvoiceDetailScreen({super.key, this.invoiceNo});

  @override
  State<InvoiceDetailScreen> createState() => _InvoiceDetailScreenState();
}

class _InvoiceDetailScreenState extends State<InvoiceDetailScreen> {
  Invoice? _invoice;
  BusinessProfile? _businessProfile;
  final DatabaseService _databaseService = DatabaseService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInvoiceDetails();
  }

  // Loads the invoice details and business profile from the database.
  Future<void> _loadInvoiceDetails() async {
    if (widget.invoiceNo != null) {
      _invoice = await _databaseService.getInvoiceById(widget.invoiceNo!);
    }
    _businessProfile = (await _databaseService.getBusinessProfile()) as BusinessProfile?;
    setState(() {
      _isLoading = false;
    });
  }

  // Shows a custom confirmation dialog instead of alert().
  Future<bool?> _showConfirmationDialog(String title, String content) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  // Handles deleting an invoice.
  void _deleteInvoice() async {
    final confirm = await _showConfirmationDialog(
      'Confirm Deletion',
      'Are you sure you want to delete this invoice?',
    );

    if (confirm == true && _invoice != null) {
      await _databaseService.deleteInvoice(_invoice!.invoiceNo as int);
      if (mounted) {
        Navigator.pop(context, true); // Pop back to previous screen and indicate success.
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Invoice Details')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_invoice == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Invoice Not Found')),
        body: const Center(child: Text('Invoice details could not be loaded.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice #${_invoice!.invoiceNo}'),
        actions: [
          // Edit button
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              await Navigator.pushNamed(
                context,
                '/create_edit_invoice',
                arguments: _invoice!,
              );
              _loadInvoiceDetails(); // Reload details after editing.
            },
          ),
          // Delete button
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _deleteInvoice,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Business Profile Section (Sender)
            _buildSectionTitle('From:'),
            _businessProfile != null
                ? Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_businessProfile!.companyName, style: Theme.of(context).textTheme.titleLarge),
                          Text(_businessProfile!.address),
                          Text('Email: ${_businessProfile!.email}'),
                          Text('Phone: ${_businessProfile!.phone}'),
                          Text('PAN: ${_businessProfile!.pan}'),
                          Text('GST: ${_businessProfile!.gst}'),
                        ],
                      ),
                    ),
                  )
                : const Text('Business profile not set up.'),

            // Client Details Section (Recipient)
            _buildSectionTitle('To:'),
            Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_invoice!.client.name, style: Theme.of(context).textTheme.titleMedium),
                    Text(_invoice!.client.address),
                    Text('Email: ${_invoice!.client.email}'),
                    Text('Phone: ${_invoice!.client.phone}'),
                  ],
                ),
              ),
            ),

            // Invoice Header Details
            _buildSectionTitle('Invoice Details:'),
            Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow('Invoice No:', _invoice!.invoiceNo),
                    _buildDetailRow(
                      'Date:',
                      DateFormat('dd-MM-yyyy').format(DateTime.parse(_invoice!.invoiceDate)),
                    ),
                  ],
                ),
              ),
            ),

            // Invoice Items Table
            _buildSectionTitle('Items:'),
            Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(3), // Particulars
                        1: FlexColumnWidth(2), // Vehicle No
                        2: FlexColumnWidth(1.5), // Pkg
                        3: FlexColumnWidth(1.5), // Amount
                      },
                      border: TableBorder.all(color: Colors.grey.shade300),
                      children: [
                        // Table Header
                        TableRow(
                          decoration: BoxDecoration(color: Colors.blue.shade50),
                          children: const [
                            Padding(padding: EdgeInsets.all(8.0), child: Text('Particulars', style: TextStyle(fontWeight: FontWeight.bold))),
                            Padding(padding: EdgeInsets.all(8.0), child: Text('Vehicle No', style: TextStyle(fontWeight: FontWeight.bold))),
                            Padding(padding: EdgeInsets.all(8.0), child: Text('Pkg', style: TextStyle(fontWeight: FontWeight.bold))),
                            Padding(padding: EdgeInsets.all(8.0), child: Text('Amount', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.right)),
                          ],
                        ),
                        // Table Rows for Items
                        ..._invoice!.items.map((item) => TableRow(
                          children: [
                            Padding(padding: const EdgeInsets.all(8.0), child: Text(item.particulars)),
                            Padding(padding: const EdgeInsets.all(8.0), child: Text(item.vehicleNo)),
                            Padding(padding: const EdgeInsets.all(8.0), child: Text(item.pkg)),
                            Padding(padding: const EdgeInsets.all(8.0), child: Text(item.amount.toStringAsFixed(2), textAlign: TextAlign.right)),
                          ],
                        )),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Total Amount: ₹${_invoice!.totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Amount in Words: ${_invoice!.amountInWords}',
                        style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bank Details & Payment Note
            _buildSectionTitle('Payment Information:'),
            Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow('Bank Details:', _invoice!.bankDetails),
                    _buildDetailRow('Payment Note:', _invoice!.paymentNote),
                  ],
                ),
              ),
            ),
          ],
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

  // Helper widget to build detail rows.
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label ', style: const TextStyle(fontWeight: FontWeight.w600)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}