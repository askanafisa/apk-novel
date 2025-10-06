import 'package:flutter/material.dart';
import 'data_novel.dart';
import 'app_gradients.dart';
import 'confirm_dialog.dart';

class LibraryPage extends StatelessWidget {
  final List<Novel> library;
  final Function(Novel) onRemove;

  const LibraryPage({super.key, required this.library, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perpustakaan'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? AppGradients.darkGradient
              : AppGradients.lightGradient,
        ),
        child: library.isEmpty
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
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    color: isDark
                        ? Colors.grey[850]!.withOpacity(0.8)
                        : Colors.white.withOpacity(0.9),
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
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => ConfirmDialog(
                              title: "Hapus dari Perpustakaan",
                              message:
                                  "Apakah kamu yakin ingin menghapus \"${novel.title}\" dari Perpustakaan?",
                              icon: Icons.book,
                              iconColor: Colors.redAccent,
                              onConfirm: () {
                                onRemove(novel);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "${novel.title} dihapus dari Perpustakaan ❌",
                                    ),
                                    duration: const Duration(seconds: 2),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    margin: const EdgeInsets.all(12),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
