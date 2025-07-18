// lib/theme/theme_helpers.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

List<Color> getSeasonalThemeColors() {
  final month = DateTime.now().month;
  if (month >= 3 && month <= 5) {
    return [Colors.lightGreen, Colors.tealAccent]; // Spring
  } else if (month >= 6 && month <= 8) {
    return [Colors.orangeAccent, Colors.deepOrangeAccent]; // Summer
  } else if (month >= 9 && month <= 11) {
    return [Colors.brown, Colors.orange]; // Autumn
  } else {
    return [Colors.lightBlueAccent, Colors.blueGrey]; // Winter
  }
}

Widget buildAnimatedGradientBackground(List<Color> colors) {
  return AnimatedContainer(
    duration: const Duration(seconds: 5),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: colors,
      ),
    ),
  );
}

Widget buildGlowingStatBox({
  required String title,
  required String value,
  required Color color,
}) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [color.withOpacity(0.3), Colors.black12]),
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.5),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 18, color: Colors.white70),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
