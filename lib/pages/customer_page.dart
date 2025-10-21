 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart'; 
import '../cubit/order_cubit.dart'; 
import '../models/order_model.dart';


class CustomerPage extends StatelessWidget {
  const CustomerPage({super.key});


  Future<void> _launchWA(String phone, String message) async {
    
    String formattedPhone = phone;
    if (formattedPhone.startsWith('0')) {
      formattedPhone = '62${phone.substring(1)}';
    }
    
    final Uri waUrl = Uri.parse(
      'https://wa.me/$formattedPhone?text=${Uri.encodeComponent(message)}'
    );
    

    if (await canLaunchUrl(waUrl)) {
      await launchUrl(waUrl, mode: LaunchMode.externalApplication);
    } else {
      
      print("Could not launch $waUrl");
      
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text("Daftar Pesanan Pelanggan"),
        backgroundColor: const Color(0xFF67A0FE),
        elevation: 2,
      ),
      body: BlocBuilder<OrderCubit, List<Order>>(
        builder: (context, orders) {

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


          final Map<String, List<Order>> customers = {};
          for (var order in orders) {
            if (!customers.containsKey(order.customerName)) {
              customers[order.customerName] = [];
            }
            customers[order.customerName]!.add(order);
          }
          final customerNames = customers.keys.toList();

          return ListView.builder(

            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            itemCount: customerNames.length,
            itemBuilder: (context, index) {
              final customerName = customerNames[index];
              final customerOrders = customers[customerName]!;
              final lastOrder = customerOrders.last; 

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

                  subtitle: Text(
                    "${lastOrder.customerPhone}\n${customerOrders.length} pesanan | Terakhir: ${lastOrder.service}",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  
                  childrenPadding: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
                  
                  children: customerOrders.map((order) {
                    return ListTile(
                      title: Text(order.service, style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text("Tujuan: ${order.destination}"),


                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          
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
                          
                          TextButton(
                            onPressed: () {
                             
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