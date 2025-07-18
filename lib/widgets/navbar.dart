// lib/widgets/bottom_nav_bar.dart
import 'package:flutter/material.dart';
import 'package:mind_soul_relaxation/screens/home_screen.dart';
import 'package:mind_soul_relaxation/screens/meditation_timer_screen.dart';
import 'package:mind_soul_relaxation/screens/recommendation_screen.dart';
import 'package:mind_soul_relaxation/screens/meditation_stats_screen.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({super.key, required this.currentIndex});

  void _onTabTapped(BuildContext context, int index) {
    if (index == currentIndex) return;
    Widget target;
    switch (index) {
      case 0:
        target = const HomeScreen();
        break;
      case 1:
        target = const MeditationTimerScreen();
        break;
      case 2:
        target = const RecommendationScreen();
        break;
      case 3:
        target = const MeditationStatsScreen();
        break;
      default:
        return;
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => target));
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.tealAccent,
      unselectedItemColor: Colors.white60,
      currentIndex: currentIndex,
      onTap: (index) => _onTabTapped(context, index),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Meditate'),
        BottomNavigationBarItem(icon: Icon(Icons.emoji_emotions), label: 'Mood'),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
      ],
    );
  }
}