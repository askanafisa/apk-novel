import 'package:flutter/material.dart';
import 'data_novel.dart';
import 'app_gradients.dart'; // Pastikan file ini sudah dibuat

class DetailPage extends StatelessWidget {
  final Novel novel;

  const DetailPage({super.key, required this.novel});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark ? AppGradients.darkGradient : AppGradients.lightGradient,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AppBar Custom (Tanpa Scaffold.appBar agar gradient fullscreen)
              AppBar(
                title: Text(novel.title),
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              // Gambar Novel
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    novel.imagePath,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Judul
              Text(
                novel.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 8),

              // Penulis
              Text(
                'By ${novel.author}',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
              const SizedBox(height: 16),

              // Rating Bintang (⭐ Tetap Ada!)
              Row(
                children: [
                  // Bintang Rating
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < novel.rating ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 24,
                      );
                    }),
                  ),
                  const SizedBox(width: 8),
                  // Teks Rating
                  Text(
                    '${novel.rating}/5',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Genre & Pembaca
              Row(
                children: [
                  Chip(
                    label: Text(novel.genre),
                    backgroundColor: Colors.blue.withOpacity(0.2),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${novel.readers} pembaca',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Deskripsi
              Text(
                novel.description,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 24),

              // Tombol Mulai Membaca
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Fitur membaca belum tersedia 😊'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.menu_book),
                  label: const Text(
                    "Mulai Membaca",
                    style: TextStyle(color: Colors.white),
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