
// ignore_for_file: file_names

class InvoiceItem {
  final String particulars;     // e.g., "SARIGAM VAPI TO BHIWANDI"
  final String vehicleNo;       // e.g., "MH48 G 2260"
  final String pkg;             // e.g., "330/3300 KGS"
  final double amount;

  InvoiceItem({
    required this.particulars,
    required this.vehicleNo,
    required this.pkg,
    required this.amount,
  });

  Map<String, dynamic> toMap() => {
    'particulars': particulars,
    'vehicleNo': vehicleNo,
    'pkg': pkg,
    'amount': amount,
  };

  factory InvoiceItem.fromMap(Map<String, dynamic> map) => InvoiceItem(
    particulars: map['particulars'],
    vehicleNo: map['vehicleNo'],
    pkg: map['pkg'],
    amount: map['amount'],
  );
}
