import 'package:shared_preferences/shared_preferences.dart';

class ReadingProgress {
  static Future<void> saveProgress(String novelTitle, int chapterIndex) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('progress_$novelTitle', chapterIndex);
  }

  static Future<int> getProgress(String novelTitle) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('progress_$novelTitle') ?? 0;
  }
}
