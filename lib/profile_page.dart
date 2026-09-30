import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String userName;

  const ProfilePage({super.key, this.userName = 'BINTORO'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 45,
              backgroundColor: Colors.orange.shade100,
              child: const Icon(Icons.person, size: 50, color: Colors.orange),
            ),
            const SizedBox(height: 12),
            Text(
              userName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Pelanggan Resto',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 30),
            Card(
              elevation: 2,
              child: ListTile(
                leading: const Icon(Icons.restaurant_menu, color: Colors.orange),
                title: const Text(
                  'Menu Resto',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('Pesan makanan favorit Anda dengan mudah.'),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 2,
              child: ListTile(
                leading: const Icon(Icons.receipt_long, color: Colors.orange),
                title: const Text(
                  'Pemesanan',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('Jumlah dan harga dihitung otomatis.'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
