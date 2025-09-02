import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data_novel.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  final List<Novel> favorites;
  final Function(Novel) onToggleFavorite;
  final Function(Novel) onAddToLibrary;
  final bool isDarkMode;
  final Function(bool) onToggleTheme;

  const HomePage({
    super.key,
    required this.favorites,
    required this.onToggleFavorite,
    required this.onAddToLibrary,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentGreetingIndex = 0;
  String searchQuery = '';
  String selectedGenre = 'Semua';
  bool showGenreFilters = false;

  final List<String> greetings = [
    'Jelajahi Dunia Cerita 📚',
    'Imajinasi Tanpa Batas ✨',
    'Temukan Dirimu dalam Kata 💭',
    'Petualangan Dimulai dari Sini 🏕️',
    'Baca, Bayangkan, Hidupkan Cerita 📖',
  ];

  final List<String> genreList = [
    'Semua',
    'Fantasi',
    'Romantis',
    'Horor',
    'Petualangan',
    'Komedi',
    'Misteri',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer.periodic(const Duration(seconds: 3), (timer) {
        if (!mounted) return;
        setState(() {
          currentGreetingIndex = (currentGreetingIndex + 1) % greetings.length;
        });
      });
    });
  }

  Widget buildSection(String title, List<Novel> novels) {
    final filteredNovels = novels.where((novel) {
      final matchesSearch = novel.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
                          novel.author.toLowerCase().contains(searchQuery.toLowerCase()) ||
                          novel.genre.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesGenre = selectedGenre == 'Semua' || novel.genre == selectedGenre;
      return matchesSearch && matchesGenre;
    }).toList();

    if (filteredNovels.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: title),
        const SizedBox(height: 8),
        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: filteredNovels.length,
            itemBuilder: (context, index) {
              final novel = filteredNovels[index];
              final isFavorite = widget.favorites.contains(novel);
              return NovelCard(
                novel: novel,
                isFavorite: isFavorite,
                onToggleFavorite: () => widget.onToggleFavorite(novel),
                onAddToLibrary: () => widget.onAddToLibrary(novel),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        title: Text(
          greetings[currentGreetingIndex],
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)]
                : [Color(0xFFE1F5FE), Color(0xFFB2EBF2), Color(0xFFB39DDB)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('Dark Mode'),
                  Switch(
                    value: widget.isDarkMode,
                    onChanged: widget.onToggleTheme,
                  ),
                ],
              ),
              Text('Halo Readers 👋',
                  style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              // Search Bar dengan Filter Genre
              Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: '🔍 Cari novel, penulis, atau genre...',
                      filled: true,
                      fillColor: isDark ? Colors.grey[800] : Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          showGenreFilters ? Icons.filter_alt : Icons.filter_alt_outlined,
                          color: colorScheme.primary,
                        ),
                        onPressed: () {
                          setState(() {
                            showGenreFilters = !showGenreFilters;
                          });
                        },
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                  // Genre Filter Chips
                  if (showGenreFilters)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: genreList.map((genre) {
                          return FilterChip(
                            label: Text(genre),
                            selected: selectedGenre == genre,
                            onSelected: (selected) {
                              setState(() {
                                selectedGenre = selected ? genre : 'Semua';
                              });
                            },
                            selectedColor: colorScheme.primary.withOpacity(0.2),
                            backgroundColor: isDark ? Colors.grey[700] : Colors.grey[200],
                            labelStyle: TextStyle(
                              color: selectedGenre == genre 
                                  ? colorScheme.primary 
                                  : Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            showCheckmark: false,
                            side: BorderSide(
                              color: selectedGenre == genre 
                                  ? colorScheme.primary 
                                  : Colors.transparent,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              buildSection('📚 Populer', populerNovels),
              buildSection('❤️ Romantis', romantisNovels),
              buildSection('🧙 Fantasi', fantasiNovels),
              buildSection('👻 Horor', hororNovels),
              const Divider(thickness: 1),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).textTheme.bodyLarge?.color,
      ),
    );
  }
}

class NovelCard extends StatelessWidget {
  final Novel novel;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;
  final VoidCallback onAddToLibrary;

  const NovelCard({
    super.key,
    required this.novel,
    required this.isFavorite,
    required this.onToggleFavorite,
    required this.onAddToLibrary,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(novel: novel),
          ),
        );
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
              child: Image.asset(
                novel.imagePath,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    novel.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'by ${novel.author}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.pink,
                          size: 20,
                        ),
                        onPressed: onToggleFavorite,
                      ),
                      IconButton(
                        icon: const Icon(Icons.library_add, size: 20),
                        onPressed: onAddToLibrary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}