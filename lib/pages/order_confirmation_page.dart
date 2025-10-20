import 'package:flutter/material.dart';
import '/models/order_model.dart';
import 'order_page.dart';
class OrderConfirmationPage extends StatelessWidget {
  final Order order;

  const OrderConfirmationPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Konfirmasi Pesanan"),
        backgroundColor: const Color(0xFF67A0FE),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nama Pelanggan: ${order.customerName}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("Layanan: ${order.service}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Penjemputan: ${order.pickup}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Tujuan: ${order.destination}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Catatan: ${order.note}", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Status: ${order.status}", style: const TextStyle(fontSize: 16, color: Colors.blue)),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text("Kembali"),
            ),
          ],
        ),
      ),
    );
  }
}