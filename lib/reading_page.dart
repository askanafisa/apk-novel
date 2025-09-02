import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data_novel.dart';

class ReadingPage extends StatefulWidget {
  final Novel novel;
  final int initialChapter;

  const ReadingPage({
    super.key,
    required this.novel,
    this.initialChapter = 0,
  });

  @override
  State<ReadingPage> createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  late int currentChapter;

  @override
  void initState() {
    super.initState();
    currentChapter = widget.initialChapter;
    _saveProgress();
  }

  Future<void> _saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('last_read_chapter_${widget.novel.title}', currentChapter);
  }

  Future<void> _nextChapter() async {
    if (currentChapter < widget.novel.content.length - 1) {
      setState(() {
        currentChapter++;
      });
      await _saveProgress();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Bab ${currentChapter + 1}'),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: isDark
              ? const LinearGradient(colors: [Colors.black, Colors.grey])
              : const LinearGradient(colors: [Colors.white, Colors.lightBlueAccent]),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  widget.novel.content[currentChapter],
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (currentChapter < widget.novel.content.length - 1)
              Center(
                child: ElevatedButton(
                  onPressed: _nextChapter,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary, // Teks kontras
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  child: const Text('Lanjut ke Bab berikutnya'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}