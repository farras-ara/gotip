import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String userName;
  final VoidCallback? onLogout;

  HomePage({
    super.key,
    this.userName = "Driver",
    this.onLogout,
  });
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;
    
    final services = [
      {
        "title": "Antar Jemput",
        "icon": Icons.directions_car,
        "color": Colors.blue[50],
        "iconColor": Colors.blue,
        "desc": "Layanan antar jemput penumpang dengan cepat & aman."
      },
      {
        "title": "Titip/Beli Barang",
        "icon": Icons.shopping_bag,
        "color": Colors.green[50],
        "iconColor": Colors.green,
        "desc": "Belanja atau titip barang dengan mudah."
      },
      {
        "title": "Bantu Survei Kost",
        "icon": Icons.home_work,
        "color": Colors.orange[50],
        "iconColor": Colors.orange,
        "desc": "Survei kost sesuai permintaan pelanggan."
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF6F9FF),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(isMobile ? 60 : 70),
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
                Container(
                  width: isMobile ? 35 : 40,
                  height: isMobile ? 35 : 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      "assets/images/gotip_rmv.png",
                      height: isMobile ? 35 : 40,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.local_shipping, color: Colors.blue);
                      },
                    ),
                  ),
                ),
                SizedBox(width: isMobile ? 10 : 14),
                Text(
                  "GOTIP Driver",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isMobile ? 18 : 22,
                    color: Colors.white,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
            actions: [
              if (!isMobile) ...[
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
              ],
              IconButton(
                icon: Icon(Icons.monetization_on, 
                  color: Colors.white, 
                  size: isMobile ? 22 : 24
                ),
                tooltip: "Pendapatan",
                onPressed: () {
                  Navigator.pushNamed(context, '/income');
                },
              ),
              IconButton(
                icon: Icon(Icons.star, 
                  color: Colors.white,
                  size: isMobile ? 22 : 24
                ),
                tooltip: "Rating & Ulasan",
                onPressed: () {
                  Navigator.pushNamed(context, '/rating');
                },
              ),
              if (!isMobile)
                IconButton(
                  icon: const Icon(Icons.logout, color: Colors.white),
                  tooltip: "Logout",
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/');
                  },
                ),
              IconButton(
                icon: Icon(Icons.share, 
                  color: Colors.white,
                  size: isMobile ? 22 : 24
                ),
                tooltip: "Share",
                onPressed: () {
                },
              ),
              SizedBox(width: isMobile ? 4 : 8),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 24, 
            vertical: isMobile ? 20 : 36
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Container(
                    padding: EdgeInsets.all(isMobile ? 20 : 28),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(isMobile ? 18 : 22),
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
                          radius: isMobile ? 30 : 38,
                          backgroundColor: Colors.blue[100],
                          child: Text(
                            userName.isNotEmpty ? userName[0].toUpperCase() : "D",
                            style: TextStyle(
                              fontSize: isMobile ? 28 : 36,
                              color: const Color(0xFF2D5DAB),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: isMobile ? 16 : 24),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Selamat datang,",
                                style: TextStyle(
                                  fontSize: isMobile ? 18 : 22,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF2D5DAB),
                                ),
                              ),
                              Text(
                                userName,
                                style: TextStyle(
                                  fontSize: isMobile ? 18 : 22,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF2D5DAB),
                                ),
                              ),
                              SizedBox(height: isMobile ? 4 : 6),
                              Text(
                                "Siap melayani pelanggan hari ini? Pilih layanan di bawah ini.",
                                style: TextStyle(
                                  fontSize: isMobile ? 12 : 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: isMobile ? 24 : 32),
                  
                  Text(
                    "Layanan GOTIP",
                    style: TextStyle(
                      fontSize: isMobile ? 18 : 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2D5DAB),
                      letterSpacing: 0.5,
                    ),
                  ),
                  
                  SizedBox(height: isMobile ? 16 : 20),
                  
                  if (isMobile)
            
                    Column(
                      children: services.map((service) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Material(
                            color: service["color"] as Color?,
                            borderRadius: BorderRadius.circular(16),
                            elevation: 2,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/order',
                                  arguments: service["title"],
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(18),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 28,
                                      child: Icon(
                                        service["icon"] as IconData,
                                        color: service["iconColor"] as Color,
                                        size: 28,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            service["title"] as String,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Color(0xFF2D5DAB),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            service["desc"] as String,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    )
                  else
                    
                    Row(
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
                                    arguments: service["title"],
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
                                          color: service["iconColor"] as Color,
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
                  
                  SizedBox(height: isMobile ? 24 : 40),
                  
                  
                  Container(
                    padding: EdgeInsets.all(isMobile ? 16 : 22),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(isMobile ? 14 : 18),
                      border: Border.all(color: Colors.blue[100]!),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline, 
                          color: Colors.blue[700], 
                          size: isMobile ? 24 : 32
                        ),
                        SizedBox(width: isMobile ? 12 : 16),
                        Expanded(
                          child: Text(
                            "Pastikan selalu menjaga keselamatan, keramahan, dan profesionalisme saat melayani pelanggan. Selamat bekerja dan semoga hari Anda menyenangkan!",
                            style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: isMobile ? 13 : 16,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: isMobile ? 20 : 32),
                  
                  Container(
                    padding: EdgeInsets.all(isMobile ? 16 : 18),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.contact_phone,
                            color: Colors.blue[700],
                            size: isMobile ? 24 : 28,
                          ),
                        ),
                        SizedBox(width: isMobile ? 12 : 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "call GOTIP",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF2D5DAB),
                                  fontSize: isMobile ? 15 : 16,
                                ),
                              ),
                              SizedBox(height: isMobile ? 8 : 10),
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone, 
                                    size: isMobile ? 16 : 18, 
                                    color: Colors.blue[700]
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "085126810177",
                                    style: TextStyle(fontSize: isMobile ? 13 : 14),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Icon(
                                    Icons.camera_alt, 
                                    size: isMobile ? 16 : 18, 
                                    color: Colors.blue[700]
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "@gotip_unesa5",
                                    style: TextStyle(fontSize: isMobile ? 13 : 14),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Icon(
                                    Icons.music_note, 
                                    size: isMobile ? 16 : 18, 
                                    color: Colors.blue[700]
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "gotipkampusunesa5",
                                    style: TextStyle(fontSize: isMobile ? 13 : 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: isMobile ? 24 : 32),
                  
                  Center(
                    child: Text(
                      "© 2025 GOTIP Driver Web",
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: isMobile ? 12 : 14,
                      ),
                    ),
                  ),
                  
                  SizedBox(height: isMobile ? 16 : 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
