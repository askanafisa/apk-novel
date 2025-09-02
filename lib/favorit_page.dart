import 'package:flutter/material.dart';
import 'data_novel.dart';
import 'app_gradients.dart';  
import 'app_snackbars.dart';

class FavoritePage extends StatelessWidget {
  final List<Novel> favorites;
  const FavoritePage({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark ? AppGradients.darkGradient : AppGradients.lightGradient,
        ),
        child: favorites.isEmpty
            ? Center(
                child: Text(
                  'Belum ada novel favorit. ❤️',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final novel = favorites[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    color: isDark 
                        ? Colors.grey[850]!.withOpacity(0.8)  // Warna card dark mode
                        : Colors.white.withOpacity(0.9),        // Warna card light mode
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

                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () {
                          AppSnackbars.show("Dihapus dari Favorit ❤️", icon: Icons.favorite_border);
                        },
                      ),  
                    ),
                  );
                },
              ),
      ),
      appBar: AppBar(
        title: const Text('Favorit Kamu'),
        backgroundColor: Colors.transparent,  // Biarkan appBar transparan
        elevation: 0,
      ),
    );
  }
}