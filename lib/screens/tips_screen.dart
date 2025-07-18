// lib/screens/tips_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mind_soul_relaxation/widgets/app_scaffold.dart';

class TipsScreen extends StatefulWidget {
  const TipsScreen({super.key});

  @override
  State<TipsScreen> createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen>
    with SingleTickerProviderStateMixin {
  final List<Map<String, String>> tips = const [
    {
      'title': 'Visualization',
      'content': 'Imagine a peaceful forest or a flowing river. Let your mind explore every detail.'
    },
    {
      'title': 'Aura Cleansing',
      'content': 'Visualize a white or golden light enveloping you, clearing away negative energy.'
    },
    {
      'title': 'Breath Awareness',
      'content': 'Focus on your breath. Feel each inhale bring calm, each exhale release tension.'
    },
    {
      'title': 'Energy Grounding',
      'content': 'Picture roots growing from your feet into the Earth. Draw strength and stability.'
    },
    {
      'title': 'Affirmations',
      'content': 'Repeat positive affirmations like “I am safe,” “I am calm,” “I am loved.”'
    },
    {
      'title': 'Candle Meditation',
      'content': 'Light a candle and softly gaze at the flame. Let it quiet your thoughts and center you.'
    },
  ];

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Relaxation & Healing Tips',
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: tips.length,
          itemBuilder: (context, index) {
            final tip = tips[index];
            return Card(
              color: Colors.deepPurple.shade700.withValues(alpha: 0.8),
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tip['title']!,
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.tealAccent,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      tip['content']!,
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
