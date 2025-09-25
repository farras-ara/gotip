import 'package:flutter/material.dart';

class IncomePage extends StatelessWidget {
  const IncomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data
    final totalIncome = 110000;
    final List<Map<String, dynamic>> orders = [
      {"date": "12 Sep 2025", "service": "Antar Jemput", "amount": 25000},
      {"date": "11 Sep 2025", "service": "Titip/Beli Barang", "amount": 35000},
      {"date": "10 Sep 2025", "service": "Bantu Survei Kost", "amount": 50000},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pendapatan"),
        backgroundColor: const Color(0xFF67A0FE),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total Pendapatan",
              style: TextStyle(color: Colors.grey[700]),
            ),
            Text(
              "Rp$totalIncome",
              style: const TextStyle(
                  fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 24),
            const Text(
              "Riwayat Transaksi",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, i) {
                  final o = orders[i];
                  return ListTile(
                    leading: const Icon(Icons.monetization_on, color: Colors.green),
                    title: Text(o["service"] as String),
                    subtitle: Text(o["date"] as String),
                    trailing: Text("Rp${o["amount"]}"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}