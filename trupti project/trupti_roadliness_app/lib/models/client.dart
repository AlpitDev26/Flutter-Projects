class Client {
  final int? id; // Optional for new records
  final String name;
  final String address;
  final String email;
  final String phone;

  Client({
    this.id,
    required this.name,
    required this.address,
    required this.email,
    required this.phone,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'address': address,
    'email': email,
    'phone': phone,
  };

  factory Client.fromMap(Map<String, dynamic> map) => Client(
    id: map['id'],
    name: map['name'],
    address: map['address'],
    email: map['email'],
    phone: map['phone'],
  );
}
