// lib/models/order_model.dart (KODE LENGKAP)

class User {
  String _userName;
  String _role;

  User({
    required String userName,
    String role = "driver",
  })  : _userName = userName,
        _role = role;

  String get userName => _userName;
  String get role => _role;

  set userName(String value) => _userName = value;
  set role(String value) => _role = value;
}

class Order {
  final String id;
  String service;
  String pickup;
  String destination;
  String note;
  DateTime date;
  User user;
  String customerName;
  String customerPhone; // <-- INI TAMBAHANNYA
  String status;

  Order({
    required this.service,
    required this.pickup,
    required this.destination,
    required this.note,
    required this.date,
    required this.user,
    required this.customerName,
    required this.customerPhone, // <-- INI TAMBAHANNYA
    this.status = "pending",
  }) : id = DateTime.now().millisecondsSinceEpoch.toString(); // ID Unik Otomatis
}