import 'package:flutter/material.dart';
import 'package:mind_soul_relaxation/theme/theme_helpers.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;
  final bool useAppBar;
  final String? title;
  final List<Widget>? actions;
  final Widget? bottomNavigationBar; // <-- Add this line

  const AppScaffold({
    super.key,
    required this.child,
    this.useAppBar = true,
    this.title,
    this.actions,
    this.bottomNavigationBar, // <-- Add this line
  });

  @override
  Widget build(BuildContext context) {
    final themeColors = getSeasonalThemeColors();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: useAppBar
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: title != null ? Text(title!) : null,
              actions: actions,
              centerTitle: true,
            )
          : null,
      body: Stack(
        children: [
          buildAnimatedGradientBackground(themeColors),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: child,
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar, // <-- Add this line
    );
  }
}