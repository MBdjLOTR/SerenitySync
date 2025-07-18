// lib/screens/recommendation_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mind_soul_relaxation/widgets/app_scaffold.dart';
import 'package:mind_soul_relaxation/services/audio_service.dart';
import 'package:mind_soul_relaxation/widgets/navbar.dart';


class RecommendationScreen extends StatefulWidget {
  const RecommendationScreen({super.key});

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  final List<String> moods = [
    'Stressed',
    'Anxious',
    'Sad',
    'Tired',
    'Angry',
    'Unmotivated',
    'Peaceful'
  ];

  String? selectedMood;
  final int _currentIndex = 2;

  final Map<String, String> recommendations = {
    'Stressed': 'Try deep breathing exercises and progressive muscle relaxation.',
    'Anxious': 'Listen to calming ocean waves and do grounding meditation.',
    'Sad': 'Focus on gratitude journaling and loving-kindness meditation.',
    'Tired': 'Do a body scan meditation and rest with gentle nature sounds.',
    'Angry': 'Try walking meditation or fire visualizations to release energy.',
    'Unmotivated': 'Listen to uplifting nature melodies and repeat affirmations.',
    'Peaceful': 'Maintain this state with soft ambient music and mindfulness.',
  };

  @override
  void initState() {
    super.initState();
    AudioService().play();
  }

  @override
  void dispose() {
    AudioService().stop();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Mood-Based Recommendations',
      child: Column(
        children: [
          Text(
            "How are you feeling today?",
            style: GoogleFonts.poppins(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: moods.map((mood) {
              return ChoiceChip(
                label: Text(mood),
                selected: selectedMood == mood,
                onSelected: (_) {
                  setState(() => selectedMood = mood);
                },
                labelStyle: const TextStyle(color: Colors.white),
                selectedColor: Colors.tealAccent,
                backgroundColor: Colors.grey.shade800,
              );
            }).toList(),
          ),
          const SizedBox(height: 30),
          if (selectedMood != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recommendation:",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Colors.tealAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  recommendations[selectedMood!]!,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                )
              ],
            ),
          const SizedBox(height: 30),
          BottomNavBar(currentIndex: _currentIndex,),
        ],
      ),
    );
  }
}
