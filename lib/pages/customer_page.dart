// lib/pages/customer_page.dart (KODE LENGKAP)

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart'; // <-- TAMBAHAN BARU
import '../cubit/order_cubit.dart'; 
import '../models/order_model.dart';
// Import halaman navigasi Anda jika ada (dari pembahasan sebelumnya)
// import 'navigation_page.dart'; 

class CustomerPage extends StatelessWidget {
  const CustomerPage({super.key});

  // --- FUNGSI BARU UNTUK MEMBUKA WA ---
  Future<void> _launchWA(String phone, String message) async {
    // Ubah nomor HP ke format internasional (misal: 0812... -> 62812...)
    String formattedPhone = phone;
    if (formattedPhone.startsWith('0')) {
      formattedPhone = '62${phone.substring(1)}';
    }
    
    final Uri waUrl = Uri.parse(
      'https://wa.me/$formattedPhone?text=${Uri.encodeComponent(message)}'
    );
    
    // Untuk web, kita gunakan launchMode external
    if (await canLaunchUrl(waUrl)) {
      await launchUrl(waUrl, mode: LaunchMode.externalApplication);
    } else {
      // Tampilkan error jika tidak bisa membuka WA
      print("Could not launch $waUrl");
      // Anda bisa tambahkan SnackBar error di sini
    }
  }
  // --- SELESAI FUNGSI BARU ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ... (AppBar tetap sama) ...
        title: const Text("Daftar Pesanan Pelanggan"),
        backgroundColor: const Color(0xFF67A0FE),
        elevation: 2,
      ),
      body: BlocBuilder<OrderCubit, List<Order>>(
        builder: (context, orders) {
          // ... (Tampilan "isEmpty" tetap sama) ...
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

          // ... (Logika grouping tetap sama) ...
          final Map<String, List<Order>> customers = {};
          for (var order in orders) {
            if (!customers.containsKey(order.customerName)) {
              customers[order.customerName] = [];
            }
            customers[order.customerName]!.add(order);
          }
          final customerNames = customers.keys.toList();

          return ListView.builder(
            // ... (ListView.builder tetap sama) ...
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            itemCount: customerNames.length,
            itemBuilder: (context, index) {
              final customerName = customerNames[index];
              final customerOrders = customers[customerName]!;
              final lastOrder = customerOrders.last; 

              return Card(
                // ... (Card tetap sama) ...
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ExpansionTile(
                  // ... (Leading & Title tetap sama) ...
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
                  // --- PERBARUI SUBTITLE UNTUK MENUNJUKKAN NO HP ---
                  subtitle: Text(
                    "${lastOrder.customerPhone}\n${customerOrders.length} pesanan | Terakhir: ${lastOrder.service}",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  // --- SELESAI PERBARUAN ---
                  childrenPadding: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
                  
                  children: customerOrders.map((order) {
                    return ListTile(
                      title: Text(order.service, style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text("Tujuan: ${order.destination}"),
                      
                      // --- PERBARUI BAGIAN TRAILING/TOMBOL ---
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // --- TOMBOL BARU UNTUK CHAT WA ---
                          IconButton(
                            icon: const Icon(Icons.chat),
                            color: Colors.green,
                            tooltip: "Hubungi Pelanggan via WA",
                            onPressed: () {
                              _launchWA(
                                order.customerPhone,
                                "Halo ${order.customerName}, saya driver GOTIP. Saya sedang dalam perjalanan menjemput pesanan Anda."
                              );
                            },
                          ),
                          // --- SELESAI TOMBOL BARU ---
                          TextButton(
                            onPressed: () {
                              // Ini adalah logika untuk "Terima"
                              context.read<OrderCubit>().acceptOrder(order.id);
                              
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Pesanan diterima!"),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            },
                            child: const Text("Terima", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                          ),
                          TextButton(
                            // ... (Tombol Tolak tetap sama) ...
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
                      // --- SELESAI PERBARUAN TRAILING ---
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