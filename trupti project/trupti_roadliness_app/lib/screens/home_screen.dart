import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import '../models/invoice.dart';
import '../screens/invoice_detail_screen.dart';
import '../services/database_service.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Invoice>> _invoicesFuture;
  final DatabaseService _databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    _loadInvoices();
  }

  // Function to load invoices from the database.
  void _loadInvoices() {
    setState(() {
      _invoicesFuture = _databaseService.getInvoices();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoices'),
        actions: [
          // Button to navigate to Business Profile screen
          IconButton(
            icon: const Icon(Icons.business),
            tooltip: 'Business Profile',
            onPressed: () {
              Navigator.pushNamed(context, '/business_profile').then((_) => _loadInvoices());
            },
          ),
          // Button to navigate to Client List screen
          IconButton(
            icon: const Icon(Icons.people),
            tooltip: 'Clients',
            onPressed: () {
              Navigator.pushNamed(context, '/client_list').then((_) => _loadInvoices());
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Invoice>>(
        future: _invoicesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No invoices found. Start by creating a new one!',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              );
          } else {
            // Display the list of invoices.
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final invoice = snapshot.data![index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    onTap: () async {
                      // Navigate to Invoice Detail screen when an invoice is tapped.
                      await Navigator.pushNamed(
                        context,
                        '/invoice_detail',
                        arguments: invoice,
                      );
                      _loadInvoices(); // Reload invoices after returning from detail screen.
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            invoice.invoiceNo,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Client: ${invoice.client.name}',
                            style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Date: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(invoice.invoiceDate))}',
                            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 4),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              'Total: ₹${invoice.totalAmount.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                              ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      // Floating action button to create a new invoice.
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/create_edit_invoice');
          _loadInvoices(); // Reload invoices after returning from create screen.
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}