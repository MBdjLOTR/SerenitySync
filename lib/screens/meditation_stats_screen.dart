import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mind_soul_relaxation/theme/theme_helpers.dart';
import 'package:mind_soul_relaxation/widgets/app_scaffold.dart';
import 'package:mind_soul_relaxation/widgets/navbar.dart';

class MeditationStatsScreen extends StatefulWidget {
  const MeditationStatsScreen({super.key});

  @override
  State<MeditationStatsScreen> createState() => _MeditationStatsScreenState();
}

class _MeditationStatsScreenState extends State<MeditationStatsScreen>
    with SingleTickerProviderStateMixin {
  int _totalSessions = 0;
  int _totalMinutes = 0;
  String? _lastSession;

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  final int _currentIndex = 3;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
    _loadStats();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadStats() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _totalSessions = prefs.getInt('meditation_sessions') ?? 0;
      _totalMinutes = prefs.getInt('meditation_minutes') ?? 0;
      _lastSession = prefs.getString('last_session');
    });
  }

  List<BarChartGroupData> _generateChartData() {
    final List<BarChartGroupData> barGroups = [];
    final sessionData = List.generate(7, (i) => (_totalSessions / 7).ceil());
    for (int i = 0; i < sessionData.length; i++) {
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: sessionData[i].toDouble(),
              gradient: const LinearGradient(
                colors: [Colors.cyan, Colors.tealAccent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              width: 14,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
      );
    }
    return barGroups;
  }

  List<PieChartSectionData> _generatePieData() {
    return [
      PieChartSectionData(
        color: Colors.tealAccent,
        value: _totalMinutes.toDouble(),
        title: 'Minutes',
        titleStyle: GoogleFonts.poppins(fontSize: 12, color: Colors.black),
      ),
      PieChartSectionData(
        color: Colors.purpleAccent,
        value: _totalSessions.toDouble(),
        title: 'Sessions',
        titleStyle: GoogleFonts.poppins(fontSize: 12, color: Colors.black),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom + 16;

    return AppScaffold(
      title: 'Meditation Statistics',
      bottomNavigationBar: BottomNavBar(currentIndex: _currentIndex),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: EdgeInsets.only(bottom: bottomPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              buildGlowingStatBox(
                title: "Total Sessions",
                value: '$_totalSessions',
                color: Colors.purpleAccent,
              ),
              const SizedBox(height: 12),
              buildGlowingStatBox(
                title: 'Total Minutes',
                value: '$_totalMinutes',
                color: Colors.orangeAccent,
              ),
              const SizedBox(height: 12),
              buildGlowingStatBox(
                title: 'Last Session',
                value: _lastSession != null
                    ? DateTime.tryParse(_lastSession!)?.toLocal().toString().split(".")[0] ?? _lastSession!
                    : 'No data available',
                color: Colors.blueAccent,
              ),
              const SizedBox(height: 24),
              Text('Weekly Sessions Overview:',
                  style: GoogleFonts.poppins(
                      fontSize: 20, color: Colors.tealAccent, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(12),
                height: 180,
                child: BarChart(
                  BarChartData(
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, _) {
                            final weekdays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                weekdays[value.toInt()],
                                style: const TextStyle(color: Colors.white70, fontSize: 12),
                              ),
                            );
                          },
                        ),
                      ),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    barGroups: _generateChartData(),
                    gridData: FlGridData(show: false),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text('Session Distribution:',
                  style: GoogleFonts.poppins(
                      fontSize: 20, color: Colors.tealAccent, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              SizedBox(
                height: 180,
                child: PieChart(
                  PieChartData(
                    sections: _generatePieData(),
                    centerSpaceRadius: 40,
                    sectionsSpace: 4,
                  ),
                ),
              ),
              const Spacer(),
              Center(
                child: Text(
                  'Consistency builds calm. Keep going! 🌿',
                  style: GoogleFonts.pacifico(fontSize: 16, color: Colors.tealAccent),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
