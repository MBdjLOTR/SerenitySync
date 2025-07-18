import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:mind_soul_relaxation/widgets/animated_progress_ring.dart';
import 'package:mind_soul_relaxation/widgets/app_scaffold.dart';
import 'package:mind_soul_relaxation/widgets/navbar.dart';
import 'package:mind_soul_relaxation/screens/meditation_timer_screen.dart';
import 'package:mind_soul_relaxation/screens/recommendation_screen.dart';
import 'package:mind_soul_relaxation/screens/tips_screen.dart';
import 'package:mind_soul_relaxation/screens/meditation_stats_screen.dart';
import 'package:mind_soul_relaxation/screens/settings_screen.dart';
import 'package:mind_soul_relaxation/services/progress_tracker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double progress = 0.0;
  final int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final tracker = DailyProgressTracker();
    final p = await tracker.getTodayProgressPercent();
    setState(() => progress = p);
  }

  Widget _glowingButton(BuildContext context, String text, VoidCallback onPressed) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.tealAccent, Colors.purpleAccent],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.tealAccent,
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black.withOpacity(0.7),
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: onPressed,
        child: Text(text, style: GoogleFonts.lato(fontSize: 16)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Mind & Soul Relaxation',
      bottomNavigationBar: BottomNavBar(currentIndex: _currentIndex),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 80),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Column Content
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 50,
                      child: DefaultTextStyle(
                        style: GoogleFonts.lato(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        child: AnimatedTextKit(
                          repeatForever: true,
                          animatedTexts: [
                            TyperAnimatedText('Welcome 🌿'),
                            TyperAnimatedText('Relax your mind 🦘'),
                            TyperAnimatedText('Heal your soul ✨'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Relax, meditate and heal your energy.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 30),
                    AnimatedProgressRing(progress: progress),
                    const SizedBox(height: 30),
                    _glowingButton(context, "🦘 Start Meditation", () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const MeditationTimerScreen()));
                    }),
                    _glowingButton(context, "💬 How Are You Feeling?", () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const RecommendationScreen()));
                    }),
                    _glowingButton(context, "✨ Relaxation & Visualization Tips", () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const TipsScreen()));
                    }),
                    _glowingButton(context, "📊 View Meditation Stats", () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const MeditationStatsScreen()));
                    }),
                    _glowingButton(context, "🔔 Daily Reminder Settings", () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
                    }),
                    const SizedBox(height: 24),
                    Text(
                      "Take a deep breath. You're doing great. 🌸",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(color: Colors.white70),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),

              // Right Image
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40, right: 16),
                  child: Image.asset(
                    'assets/images/background.jpeg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
