// lib/utils/daily_progress_tracker.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class DailyProgressTracker {
  static const _keyPrefix = 'progress_';

  Future<void> logSession({int minutes = 5}) async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final key = '$_keyPrefix$today';
    int current = prefs.getInt(key) ?? 0;
    await prefs.setInt(key, current + minutes);
  }

  Future<int> getTodayMinutes() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final key = '$_keyPrefix$today';
    return prefs.getInt(key) ?? 0;
  }

  Future<double> getTodayProgressPercent({int goalMinutes = 15}) async {
    final minutes = await getTodayMinutes();
    return (minutes / goalMinutes).clamp(0.0, 1.0);
  }
}
