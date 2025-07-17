import 'package:flutter/material.dart';
import 'data_novel.dart';
import 'home_page.dart';
import 'library_page.dart';
import 'favorit_page.dart';

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
    setState(() {
      if (favorites.contains(novel)) {
        favorites.remove(novel);
      } else {
        favorites.add(novel);
      }
    });
  }

  void addToLibrary(Novel novel) {
    setState(() {
      if (!library.contains(novel)) {
        library.add(novel);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(
        favorites: favorites,
        onToggleFavorite: toggleFavorite,
        onAddToLibrary: addToLibrary,
        isDarkMode: widget.isDarkMode,
        onToggleTheme: widget.toggleTheme,
      ),
      LibraryPage(library: library),
      FavoritePage(favorites: favorites),
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
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Perpustakaan'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorit'),
        ],
      ),
    );
  }
}
