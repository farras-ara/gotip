import 'package:flutter/material.dart';

class CustomerPage extends StatelessWidget {
  const CustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final customers = [
      {"name": "Andi", "email": "andi@email.com", "phone": "08123456789"},
      {"name": "Budi", "email": "budi@email.com", "phone": "08129876543"},
      {"name": "Citra", "email": "citra@email.com", "phone": "08121234567"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Pelanggan"),
        backgroundColor: const Color(0xFF67A0FE),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: customers.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, i) {
          final c = customers[i];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue[100],
              child: Text(c["name"]![0]),
            ),
            title: Text(c["name"]!),
            subtitle: Text("${c["email"]}\n${c["phone"]}"),
            isThreeLine: true,
            trailing: const Icon(Icons.person),
          );
        },
      ),
    );
  }
}