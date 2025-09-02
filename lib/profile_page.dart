import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // hapus semua data login
    // arahkan ke halaman login, hapus semua stack route
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Saya"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Foto Profil
            CircleAvatar(
              radius: 50,
              backgroundColor: colorScheme.primaryContainer,
              child: Icon(Icons.person, size: 50, color: colorScheme.onPrimaryContainer),
            ),
            const SizedBox(height: 16),

            // Nama & Bio (sementara statis)
            Center(
              child: Column(
                children: const [
                  Text(
                    "Aska Nafisa",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text("Pecinta Novel & Penulis Pemula"),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Informasi akun
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: const [
                  ListTile(
                    leading: Icon(Icons.book),
                    title: Text("Buku Dibaca"),
                    trailing: Text("12"),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text("Favorit"),
                    trailing: Text("8"),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.history),
                    title: Text("Riwayat Baca"),
                    trailing: Text("5"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Tombol Edit Profil
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // nanti bisa diarahkan ke halaman edit profil
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Fitur Edit Profil belum tersedia")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text("Edit Profil"),
              ),
            ),
            const SizedBox(height: 12),

            // Tombol Logout
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => _logout(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: colorScheme.error),
                ),
                child: Text(
                  "Keluar",
                  style: TextStyle(color: colorScheme.error),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
