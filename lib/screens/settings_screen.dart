// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mind_soul_relaxation/services/notification_service.dart';
import 'package:mind_soul_relaxation/utils/notification_dialogue.dart';
import 'package:mind_soul_relaxation/widgets/app_scaffold.dart';
import 'package:mind_soul_relaxation/theme/theme_helpers.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TimeOfDay _selectedTime = const TimeOfDay(hour: 20, minute: 0); // default: 8 PM

  @override
  void initState() {
    super.initState();
    _loadNotificationTime();
  }

  Future<void> _loadNotificationTime() async {
    final prefs = await SharedPreferences.getInstance();
    final hour = prefs.getInt('notify_hour') ?? 20;
    final minute = prefs.getInt('notify_minute') ?? 0;
    setState(() => _selectedTime = TimeOfDay(hour: hour, minute: minute));
  }

  Future<void> _saveNotificationTime(TimeOfDay time) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('notify_hour', time.hour);
    await prefs.setInt('notify_minute', time.minute);
    NotificationService().scheduleDailyReminder(hour: time.hour, minute: time.minute);
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() => _selectedTime = picked);
      await _saveNotificationTime(picked);
      await showNotificationConfirmation(context, picked.format(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeColors = getSeasonalThemeColors();

    return AppScaffold(
      title: 'Settings',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daily Reminder Time',
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          buildGlowingStatBox(
            title: 'Current Reminder Time',
            value: _selectedTime.format(context),
            color: themeColors.first,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _pickTime,
            style: ElevatedButton.styleFrom(
              backgroundColor: themeColors.first.withOpacity(0.8),
            ),
            child: Text(
              'Change Reminder Time',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'You will get a reminder every day at this time to relax and meditate. 🌙',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}