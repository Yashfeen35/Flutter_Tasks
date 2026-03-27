import 'package:flutter/material.dart';
import 'components/bottom_nav.dart';
import 'components/text.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  bool _calendarTapped = false;
  bool _settingsTapped = false;
  DateTime? _selectedDate;

  Future<void> _openCalendar() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _calendarTapped = true;
      });
      final formatted =
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Selected date: $formatted')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const CustomText(
          text: 'Progress',
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        actions: [
          IconButton(
            onPressed: _openCalendar,
            icon: Icon(
              Icons.calendar_today_outlined,
              color: _calendarTapped
                  ? Theme.of(context).primaryColor
                  : Colors.grey.shade700,
            ),
            tooltip: 'Calendar',
          ),
          IconButton(
            onPressed: () => setState(() => _settingsTapped = !_settingsTapped),
            icon: Icon(
              Icons.settings_outlined,
              color: _settingsTapped
                  ? Theme.of(context).primaryColor
                  : Colors.grey.shade700,
            ),
            tooltip: 'Settings',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Goal progress card
              Container(
                padding: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircularPercentIndicator(
                      radius: 60,
                      lineWidth: 10,
                      percent: 0.73,
                      progressColor: Theme.of(context).primaryColor,
                      backgroundColor: Colors.grey.shade200,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            '73%',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text('Goal', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Weekly Activity',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'You are 27% away from your weekly goal. Keep going!',
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              // use Expanded so the three stat items share available width and won't overflow
                              Expanded(
                                child: _StatItem(
                                  label: 'Workouts',
                                  value: '12',
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _StatItem(
                                  label: 'Calories',
                                  value: '4,200',
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _StatItem(label: 'Hours', value: '5.2'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Recent Workouts',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              _ActivityTile(
                title: 'Morning Run',
                subtitle: 'Cardio · 30 min',
                icon: Icons.directions_run,
              ),
              const SizedBox(height: 10),
              _ActivityTile(
                title: 'Evening Yoga',
                subtitle: 'Flexibility · 20 min',
                icon: Icons.self_improvement,
              ),
              const SizedBox(height: 10),
              _ActivityTile(
                title: 'Strength Circuit',
                subtitle: 'Strength · 45 min',
                icon: Icons.fitness_center,
              ),

              const SizedBox(height: 30),

              const Text(
                'Trends',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // Placeholder for a small chart area
              Container(
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Center(
                  child: Text(
                    'Chart placeholder',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
              ),

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // value may be longer on small screens; show with ellipsis (avoid Flexible to prevent layout errors)
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  const _ActivityTile({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 28, color: Theme.of(context).primaryColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey.shade700),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Text('Today', style: TextStyle(color: Colors.grey.shade600)),
        ],
      ),
    );
  }
}
