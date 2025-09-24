import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String userName;
  const HomePage({super.key, this.userName = "Driver"});

  @override
  Widget build(BuildContext context) {
    final services = [
      {
        "title": "Antar Jemput",
        "icon": Icons.directions_car,
        "color": Colors.blue[50],
        "desc": "Layanan antar jemput penumpang dengan cepat & aman."
      },
      {
        "title": "Titip/Beli Barang",
        "icon": Icons.shopping_bag,
        "color": Colors.green[50],
        "desc": "Belanja atau titip barang dengan mudah."
      },
      {
        "title": "Bantu Survei Kost",
        "icon": Icons.home_work,
        "color": Colors.orange[50],
        "desc": "Survei kost sesuai permintaan pelanggan."
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF6F9FF),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF67A0FE), Color(0xFF2D5DAB)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x22000000),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    "assets/images/gotip_rmv.png",
                    height: 40,
                  ),
                ),
                const SizedBox(width: 14),
                const Text(
                  "GOTIP Driver",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.account_circle, color: Colors.white),
                tooltip: "Profil",
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
              IconButton(
                icon: const Icon(Icons.people, color: Colors.white),
                tooltip: "Pelanggan",
                onPressed: () {
                  Navigator.pushNamed(context, '/customers');
                },
              ),
              IconButton(
                icon: const Icon(Icons.monetization_on, color: Colors.white),
                tooltip: "Pendapatan",
                onPressed: () {
                  Navigator.pushNamed(context, '/income');
                },
              ),
              IconButton(
                icon: const Icon(Icons.star, color: Colors.white),
                tooltip: "Rating & Ulasan",
                onPressed: () {
                  Navigator.pushNamed(context, '/rating');
                },
              ),
              IconButton(
                icon: const Icon(Icons.logout, color: Colors.white),
                tooltip: "Logout",
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
            children: [
              Container(
                padding: const EdgeInsets.all(28),
                margin: const EdgeInsets.only(bottom: 32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.07),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 38,
                      backgroundColor: Colors.blue[100],
                      child: Text(
                        userName.isNotEmpty ? userName[0].toUpperCase() : "D",
                        style: const TextStyle(
                          fontSize: 36,
                          color: Color(0xFF2D5DAB),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Selamat datang, $userName",
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D5DAB),
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            "Siap melayani pelanggan hari ini? Pilih layanan di bawah ini.",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                "Layanan GOTIP",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D5DAB),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: services.map((service) {
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: Material(
                        color: service["color"] as Color?,
                        borderRadius: BorderRadius.circular(18),
                        elevation: 4,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(18),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/order',
                              arguments: service["title"], // Kirim nama layanan
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 32, horizontal: 12),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 32,
                                  child: Icon(
                                    service["icon"] as IconData,
                                    color: Colors.blueAccent,
                                    size: 36,
                                  ),
                                ),
                                const SizedBox(height: 18),
                                Text(
                                  service["title"] as String,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Color(0xFF2D5DAB),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  service["desc"] as String,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.blue[100]!),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: Colors.blueAccent, size: 32),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        "Pastikan selalu menjaga keselamatan, keramahan, dan profesionalisme saat melayani pelanggan. Selamat bekerja dan semoga hari Anda menyenangkan!",
                        style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.contact_phone, color: Colors.blueAccent),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "call GOTIP",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D5DAB),
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.phone, size: 18, color: Color(0xFF2D5DAB)),
                              SizedBox(width: 8),
                              Text("085126810177"),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.camera_alt, size: 18, color: Color(0xFF2D5DAB)), // Instagram icon alternative
                              SizedBox(width: 8),
                              Text("@gotip_unesa5"),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.tiktok, size: 18, color: Color(0xFF2D5DAB)), // tiktok icon alternative
                              SizedBox(width: 8),
                              Text("gotipkampusunesa5"),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: Text(
                  "© 2025 GOTIP Driver Web",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
