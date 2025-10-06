import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data_novel.dart';
import 'app_gradients.dart';
import 'reading_page.dart';

class DetailPage extends StatefulWidget {
  final Novel novel;

  const DetailPage({super.key, required this.novel});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int? lastReadChapter;

  @override
  void initState() {
    super.initState();
    loadLastReadChapter();
  }

  Future<void> loadLastReadChapter() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIndex = prefs.getInt('last_read_chapter_${widget.novel.title}');
    if (savedIndex != null) {
      setState(() {
        lastReadChapter = savedIndex;
      });
    }
  }

  Future<void> saveLastReadChapter(int chapterIndex) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('last_read_chapter_${widget.novel.title}', chapterIndex);
    setState(() {
      lastReadChapter = chapterIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? AppGradients.darkGradient
              : AppGradients.lightGradient,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                title: Text(widget.novel.title),
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    widget.novel.imagePath,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.novel.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'By ${widget.novel.author}',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < widget.novel.rating
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 24,
                      );
                    }),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${widget.novel.rating}/5',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Chip(
                    label: Text(widget.novel.genre),
                    backgroundColor: Colors.blue.withOpacity(0.2),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${widget.novel.readers} pembaca',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                widget.novel.description,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 24),

              // 🔄 Tombol Lanjutkan Membaca
              if (lastReadChapter != null)
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReadingPage(
                            novel: widget.novel,
                            initialChapter: lastReadChapter!,
                          ),
                        ),
                      ).then((_) {
                        loadLastReadChapter(); // refresh otomatis setelah keluar
                      });
                    },
                    icon: const Icon(Icons.menu_book, color: Colors.white),
                    label: Text(
                      "📚 Lanjutkan Bab ${lastReadChapter! + 1}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      backgroundColor: Colors.deepPurple,
                    ),
                  ),
                ),

              const SizedBox(height: 16),

              // Tombol Mulai Membaca (hanya muncul kalau belum ada progres)
              if (lastReadChapter == null)
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReadingPage(
                            novel: widget.novel,
                            initialChapter: 0,
                          ),
                        ),
                      ).then((_) {
                        loadLastReadChapter(); // langsung cek lagi setelah keluar
                      });
                    },
                    icon: const Icon(Icons.menu_book, color: Colors.white),
                    label: const Text(
                      "📖 Mulai Membaca 📖",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

              const SizedBox(height: 24),

              // Daftar Bab
              Text(
                "Daftar Bab",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 12),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Card(
                    color: Theme.of(context).cardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.book,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text("Bab ${index + 1}"),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReadingPage(
                              novel: widget.novel,
                              initialChapter: index,
                            ),
                          ),
                        ).then((_) {
                          saveLastReadChapter(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
