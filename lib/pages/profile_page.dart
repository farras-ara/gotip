import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String userName;
  ProfilePage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Driver"),
        backgroundColor: const Color(0xFF67A0FE),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: Colors.blue[100],
              child: Text(
                userName.isNotEmpty ? userName[0].toUpperCase() : "D",
                style: const TextStyle(fontSize: 40, color: Color(0xFF2D5DAB)),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              userName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("Driver Ojek Online"),
            const SizedBox(height: 32),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text("Email"),
              subtitle: Text("$userName,@email.com"),
            ),

            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text("No. HP"),
              subtitle: const Text ("085134256764"),
            ),
          ],
        ),
      ),
    );
  }
}