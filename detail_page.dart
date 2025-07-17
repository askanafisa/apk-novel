import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data_novel.dart';

class DetailPage extends StatelessWidget {
  final Novel novel;
  const DetailPage({super.key, required this.novel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(novel.title, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar novel dengan rounded corner
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                novel.imagePath,
                width: double.infinity,
                height: 240,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // Judul dan penulis
            Text(
              novel.title,
              style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              'by ${novel.author}',
              style: GoogleFonts.poppins(color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),

            // Rating dan jumlah pembaca
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber[700]),
                const SizedBox(width: 4),
                Text(
                  '${novel.rating} • ${novel.readers} pembaca',
                  style: GoogleFonts.poppins(fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Genre sebagai chip
            Chip(label: Text(novel.genre)),

            const SizedBox(height: 20),

            // Sinopsis / deskripsi
            Text(
              'Sinopsis',
              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              novel.description,
              style: GoogleFonts.poppins(fontSize: 14),
            ),

            const SizedBox(height: 24),

            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Fitur baca belum tersedia 🛠")),
                  );
                },
                icon: const Icon(Icons.book),
                label: const Text("Baca Sekarang"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
