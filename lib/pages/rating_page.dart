import 'package:flutter/material.dart';

class RatingPage extends StatelessWidget {
  const RatingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ratings = [
      {"customer": "Andi", "rating": 5, "review": "Sangat ramah dan cepat!"},
      {"customer": "Budi", "rating": 4, "review": "Pelayanan baik."},
      {"customer": "Citra", "rating": 5, "review": "Driver terbaik!"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Rating & Ulasan"),
        backgroundColor: const Color(0xFF67A0FE),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: ratings.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, i) {
          final r = ratings[i];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue[100],
              child: Text((r["customer"] as String)[0]), // cast ke String
            ),
            title: Text(r["customer"] as String), // cast ke String
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: List.generate(
                    r["rating"] as int,
                    (index) => const Icon(Icons.star, color: Colors.amber, size: 18),
                  ),
                ),
                Text(r["review"] as String), // cast ke String
              ],
            ),
          );
        },
      ),
    );
  }
}