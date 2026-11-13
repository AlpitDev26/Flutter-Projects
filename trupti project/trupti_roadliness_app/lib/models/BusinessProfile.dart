class BusinessProfile {
  final String companyName;
  final String address;
  final String email;
  final String phone;
  final String pan;
  final String gst;
  final String bankName;
  final String accountNo;
  final String ifsc;

  BusinessProfile({
    required this.companyName,
    required this.address,
    required this.email,
    required this.phone,
    required this.pan,
    required this.gst,
    required this.bankName,
    required this.accountNo,
    required this.ifsc,
  });

  Map<String, dynamic> toMap() => {
    'companyName': companyName,
    'address': address,
    'email': email,
    'phone': phone,
    'pan': pan,
    'gst': gst,
    'bankName': bankName,
    'accountNo': accountNo,
    'ifsc': ifsc,
  };

  factory BusinessProfile.fromMap(Map<String, dynamic> map) => BusinessProfile(
    companyName: map['companyName'],
    address: map['address'],
    email: map['email'],
    phone: map['phone'],
    pan: map['pan'],
    gst: map['gst'],
    bankName: map['bankName'],
    accountNo: map['accountNo'],
    ifsc: map['ifsc'],
  );
}
