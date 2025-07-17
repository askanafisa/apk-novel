import 'package:flutter/material.dart';
import 'data_novel.dart';


class FavoritePage extends StatelessWidget {
  final List<Novel> favorites;

  const FavoritePage({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorit Kamu'),
        backgroundColor: const Color.fromARGB(255, 237, 177, 88),
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Text(
                'Belum ada novel favorit. ❤️',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final novel = favorites[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                    title: Text(novel.title,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('by ${novel.author}'),
                  ),
                );
              },
            ),
    );
  }
}
