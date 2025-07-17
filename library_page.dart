import 'package:flutter/material.dart';
import 'data_novel.dart';

class LibraryPage extends StatelessWidget {
  final List<Novel> library;
  const LibraryPage({super.key, required this.library});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perpustakaan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        elevation: 2,
      ),
      body: library.isEmpty
          ? Center(
              child: Text(
                'Belum ada novel di perpustakaan kamu. 📚',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            )
          : ListView.builder(
              itemCount: library.length,
              itemBuilder: (context, index) {
                final novel = library[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: Theme.of(context).cardColor,
                  elevation: 2,
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        novel.imagePath,
                        width: 50,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      novel.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    subtitle: Text(
                      'by ${novel.author}',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
