import 'profile_page.dart';
import 'package:flutter/material.dart';
import 'data_novel.dart';
import 'home_page.dart';
import 'library_page.dart';
import 'favorit_page.dart';
import 'app_snackbars.dart';

class MainPage extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) toggleTheme;

  const MainPage({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Novel> favorites = [];
  final List<Novel> library = [];

  void toggleFavorite(Novel novel) {
    final isAdded = !favorites.contains(novel);

    setState(() {
      if (isAdded) {
        favorites.add(novel);
      } else {
        favorites.remove(novel);
      }
    });

    // ✅ SnackBar untuk favorit
    if (isAdded) {
      AppSnackbars.show("Ditambahkan ke Favorit ❤️", icon: Icons.favorite);
    } else {
      AppSnackbars.show("Dihapus dari Favorit", icon: Icons.favorite_border);
    }
  }

  void addToLibrary(Novel novel) {
    // Kalau sudah ada, kasih info lalu keluar
    if (library.contains(novel)) {
      AppSnackbars.show("Sudah ada di Perpustakaan", icon: Icons.info_outline);
      return;
    }

    setState(() {
      library.add(novel);
    });

    // ✅ SnackBar untuk perpustakaan
    AppSnackbars.show(
      "Ditambahkan ke Perpustakaan 📚",
      icon: Icons.library_add_check,
    );

    // (opsional) kalau mau otomatis pindah ke tab Perpustakaan, buka komentar ini:
    // setState(() => _currentIndex = 1);
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(
        favorites: favorites,
        onToggleFavorite: toggleFavorite,
        onAddToLibrary: addToLibrary,
        library: library,
        isDarkMode: widget.isDarkMode,
        onToggleTheme: widget.toggleTheme,
      ),
      LibraryPage(
        library: library,
        onRemove: (novel) {
          setState(() => library.remove(novel));
        },
      ),
      FavoritePage(
        favorites: favorites,
        onRemove: (novel) {
          setState(() => favorites.remove(novel));
        },
      ),
      const ProfilePage(),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).unselectedWidgetColor,
        backgroundColor: Theme.of(context).colorScheme.surface,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Perpustakaan',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorit'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
