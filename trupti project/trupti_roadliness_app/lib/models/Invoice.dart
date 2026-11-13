import 'client.dart';
import 'InvoiceItems.dart';

class Invoice {
  // final int? id;
  final String invoiceNo;
  final String invoiceDate;
  final Client client;
  final List<InvoiceItem> items;
  final double totalAmount;
  final String amountInWords;
  final String bankDetails;
  final String paymentNote;

  Invoice({
    // this.id,
    required this.invoiceNo,
    required this.invoiceDate,
    required this.client,
    required this.items,
    required this.totalAmount,
    required this.amountInWords,
    required this.bankDetails,
    required this.paymentNote, required id,
  });

  Map<String, dynamic> toMap() => {
    // 'id': id,
    'invoiceNo': invoiceNo,
    'invoiceDate': invoiceDate,
    'client': client.toMap(),
    'items': items.map((item) => item.toMap()).toList(),
    'totalAmount': totalAmount,
    'amountInWords': amountInWords,
    'bankDetails': bankDetails,
    'paymentNote': paymentNote,
  };

  factory Invoice.fromMap(Map<String, dynamic> map) => Invoice(
    id: map['invoiceNo'],
    invoiceNo: map['invoiceNo'],
    invoiceDate: map['invoiceDate'],
    client: Client.fromMap(Map<String, dynamic>.from(map['client'])),
    items: (map['items'] as List<dynamic>)
        .map((e) => InvoiceItem.fromMap(Map<String, dynamic>.from(e)))
        .toList(),
    totalAmount: map['totalAmount'],
    amountInWords: map['amountInWords'],
    bankDetails: map['bankDetails'],
    paymentNote: map['paymentNote'],
  );

  get id => null;
}
