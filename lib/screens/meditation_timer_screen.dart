// lib/screens/meditation_timer_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/audio_service.dart';
import 'package:mind_soul_relaxation/widgets/app_scaffold.dart';
import 'package:mind_soul_relaxation/widgets/navbar.dart';

class MeditationTimerScreen extends StatefulWidget {
  const MeditationTimerScreen({super.key});

  @override
  State<MeditationTimerScreen> createState() => _MeditationTimerScreenState();
}

class _MeditationTimerScreenState extends State<MeditationTimerScreen> {
  static const int defaultDuration = 5 * 60; // 5 minutes
  late int remainingTime;
  Timer? timer;
  bool isRunning = false;
  final int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
    remainingTime = defaultDuration;
    AudioService().play();
  }

  @override
  void dispose() {
    timer?.cancel();
    AudioService().stop();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (remainingTime > 0) {
        setState(() => remainingTime--);
      } else {
        stopTimer();
        _saveSession(defaultDuration ~/ 60); // save after completion
      }
    });
  }

  void stopTimer() {
    timer?.cancel();
    setState(() => isRunning = false);
  }

  void toggleTimer() {
    if (isRunning) {
      stopTimer();
    } else {
      startTimer();
    }
    setState(() => isRunning = !isRunning);
  }

  void resetTimer() {
    stopTimer();
    setState(() => remainingTime = defaultDuration);
  }

  Future<void> _saveSession(int minutes) async {
    final prefs = await SharedPreferences.getInstance();
    final totalSessions = prefs.getInt('meditation_sessions') ?? 0;
    final totalMinutes = prefs.getInt('meditation_minutes') ?? 0;

    await prefs.setInt('meditation_sessions', totalSessions + 1);
    await prefs.setInt('meditation_minutes', totalMinutes + minutes);
    await prefs.setString('last_session', DateTime.now().toIso8601String());
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Meditation Timer',
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 90),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Lottie.asset('assets/animations/MeditatingGiraffe.json', height: 180),
              const SizedBox(height: 24),
              Text(
                formatTime(remainingTime),
                style: GoogleFonts.lato(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(color: Colors.tealAccent.withValues(), blurRadius: 12),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: toggleTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.tealAccent,
                      foregroundColor: Colors.black,
                      elevation: 6,
                      shadowColor: Colors.tealAccent,
                    ),
                    child: Text(isRunning ? 'Pause' : 'Start'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: resetTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purpleAccent,
                      foregroundColor: Colors.black,
                      elevation: 6,
                      shadowColor: Colors.purpleAccent,
                    ),
                    child: const Text('Reset'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.tealAccent,
                      blurRadius: 12,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: BottomNavBar(currentIndex: _currentIndex),
              ),
            ],
          ),
        ),
      ),
    );
  }
}