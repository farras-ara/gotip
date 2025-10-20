import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/order_model.dart'; 
import '../cubit/order_cubit.dart';   

class OrderPage extends StatefulWidget {
  final String? initialService;
  final User user;

  OrderPage({
    super.key,
    required String userName, 
    this.initialService,
  }) : user = User(userName: userName); 

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late String selectedService;
  final customerNameController = TextEditingController();
  final pickupController = TextEditingController();
  final destinationController = TextEditingController();
  final itemController = TextEditingController();
  final surveyLocationController = TextEditingController();
  final noteController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    selectedService = widget.initialService ?? "Antar Jemput";
  }

  @override
  Widget build(BuildContext context) {
    final serviceIcons = {
      "Antar Jemput": Icons.directions_car,
      "Titip/Beli Barang": Icons.shopping_bag,
      "Bantu Survei Kost": Icons.home_work,
    };

    return Scaffold(
      backgroundColor: const Color(0xFFF6F9FF),
      appBar: AppBar(
        title: const Text("Buat Order"),
        backgroundColor: const Color(0xFF67A0FE),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        serviceIcons[selectedService],
                        color: Colors.blueAccent,
                        size: 48,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Order Layanan ${selectedService.toUpperCase()}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D5DAB),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 28),
                      DropdownButtonFormField<String>(
                        value: selectedService,
                        items: serviceIcons.keys
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Row(
                                    children: [
                                      Icon(serviceIcons[e], color: Colors.blueAccent),
                                      const SizedBox(width: 8),
                                      Text(e),
                                    ],
                                  ),
                                ))
                            .toList(),
                        onChanged: (val) => setState(() => selectedService = val!),
                        decoration: InputDecoration(
                          labelText: "Pilih Layanan",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      TextFormField(
                        controller: customerNameController,
                        decoration: InputDecoration(
                          labelText: "Nama Pelanggan",
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        validator: (v) =>
                            v == null || v.isEmpty ? "Nama pelanggan wajib diisi" : null,
                      ),
                      const SizedBox(height: 18),
                      if (selectedService == "Antar Jemput") ...[
                        TextFormField(
                          controller: pickupController,
                          decoration: InputDecoration(
                            labelText: "Alamat Jemput",
                            prefixIcon: const Icon(Icons.location_on),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? "Alamat jemput wajib diisi" : null,
                        ),
                        const SizedBox(height: 18),
                        TextFormField(
                          controller: destinationController,
                          decoration: InputDecoration(
                            labelText: "Alamat Tujuan",
                            prefixIcon: const Icon(Icons.flag),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? "Alamat tujuan wajib diisi" : null,
                        ),
                        const SizedBox(height: 18),
                      ],


                      if (selectedService == "Titip/Beli Barang") ...[
                        TextFormField(
                          controller: itemController,
                          decoration: InputDecoration(
                            labelText: "Barang yang Dititip/Beli",
                            prefixIcon: const Icon(Icons.shopping_cart),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? "Barang wajib diisi" : null,
                        ),
                        const SizedBox(height: 18),
                        TextFormField(
                          controller: pickupController,
                          decoration: InputDecoration(
                            labelText: "Alamat Toko/Penjual",
                            prefixIcon: const Icon(Icons.store),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? "Alamat toko wajib diisi" : null,
                        ),
                        const SizedBox(height: 18),
                        TextFormField(
                          controller: destinationController,
                          decoration: InputDecoration(
                            labelText: "Alamat Pengantaran",
                            prefixIcon: const Icon(Icons.home),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? "Alamat pengantaran wajib diisi" : null,
                        ),
                        const SizedBox(height: 18),
                      ],


                      if (selectedService == "Bantu Survei Kost") ...[
                        TextFormField(
                          controller: surveyLocationController,
                          decoration: InputDecoration(
                            labelText: "Lokasi Kost yang Disurvei",
                            prefixIcon: const Icon(Icons.home_work),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? "Lokasi kost wajib diisi" : null,
                        ),
                        const SizedBox(height: 18),
                        TextFormField(
                          controller: destinationController,
                          decoration: InputDecoration(
                            labelText: "Alamat Pengiriman Laporan",
                            prefixIcon: const Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? "Alamat pengiriman wajib diisi" : null,
                        ),
                        const SizedBox(height: 18),
                      ],

                      TextFormField(
                        controller: noteController,
                        decoration: InputDecoration(
                          labelText: "Catatan (opsional)",
                          prefixIcon: const Icon(Icons.note_alt),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        minLines: 1,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.send),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF67A0FE),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {

                              String pickup = "";
                              String destination = "";
                              String note = noteController.text;

                              if (selectedService == "Antar Jemput") {
                                pickup = pickupController.text;
                                destination = destinationController.text;
                              } else if (selectedService == "Titip/Beli Barang") {
                                pickup = pickupController.text;
                                destination = destinationController.text;
                                note = "Barang: ${itemController.text}. Catatan: $note";
                              } else if (selectedService == "Bantu Survei Kost") {
                                pickup = surveyLocationController.text;
                                destination = destinationController.text;
                              }


                              final order = Order(
                                service: selectedService,
                                pickup: pickup,
                                destination: destination,
                                note: note,
                                date: DateTime.now(),
                                user: widget.user,
                                customerName: customerNameController.text,
                              );

                              context.read<OrderCubit>().addOrder(order);
                              Navigator.pushReplacementNamed(context, '/customers');
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Order berhasil dibuat!"),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          },
                          label: const Text("Pesan Sekarang"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

