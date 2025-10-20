import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/order_cubit.dart'; // <-- Perbaikan 1: Import OrderCubit secara langsung
import '../models/order_model.dart';

class CustomerPage extends StatelessWidget {
  const CustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Pesanan Pelanggan"),
        backgroundColor: const Color(0xFF67A0FE),
        elevation: 2,
      ),
      // Menggunakan BlocBuilder untuk mendengarkan perubahan dari OrderCubit
      body: BlocBuilder<OrderCubit, List<Order>>(
        builder: (context, orders) {
          // Tampilan jika tidak ada pesanan sama sekali
          if (orders.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    "Belum ada pesanan masuk.",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          // Logika untuk mengelompokkan pesanan berdasarkan nama pelanggan
          final Map<String, List<Order>> customers = {};
          for (var order in orders) {
            if (!customers.containsKey(order.customerName)) {
              customers[order.customerName] = [];
            }
            customers[order.customerName]!.add(order);
          }

          final customerNames = customers.keys.toList();

          // Menampilkan daftar pelanggan dalam ListView
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            itemCount: customerNames.length,
            itemBuilder: (context, index) {
              final customerName = customerNames[index];
              final customerOrders = customers[customerName]!;
              final lastOrder = customerOrders.last; // Ambil order terakhir untuk info

              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ExpansionTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue[50],
                    child: Text(
                      customerName.isNotEmpty ? customerName[0].toUpperCase() : '?',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D5DAB),
                      ),
                    ),
                  ),
                  title: Text(
                    customerName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  subtitle: Text("${customerOrders.length} pesanan | Terakhir: ${lastOrder.service}"),
                  childrenPadding: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
                  // Menampilkan detail setiap pesanan dari pelanggan tersebut
                  children: customerOrders.map((order) {
                    return ListTile(
                      title: Text(order.service, style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text("Tujuan: ${order.destination}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Tombol untuk menerima pesanan
                          TextButton(
                            onPressed: () {
                              context.read<OrderCubit>().acceptOrder(order.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Pesanan dari ${order.customerName} diterima."),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            },
                            child: const Text("Terima", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                          ),
                          // Tombol untuk menolak pesanan
                          TextButton(
                            onPressed: () {
                              context.read<OrderCubit>().rejectOrder(order.id);
                               ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Pesanan dari ${order.customerName} ditolak."),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            },
                            child: const Text("Tolak", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}