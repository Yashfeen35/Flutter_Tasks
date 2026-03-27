import 'package:flutter/material.dart';
import 'package:fitlife/components/buttons.dart';
import 'package:fitlife/components/text.dart';
import 'package:fitlife/all_set_screen.dart';
import 'package:get/get.dart';

class WorkoutDurationScreen extends StatefulWidget {
  final String? fitnessGoal;
  final String? activityLevel;
  final List<String>? workoutTypes;

  const WorkoutDurationScreen({
    super.key,
    this.fitnessGoal,
    this.activityLevel,
    this.workoutTypes,
  });

  @override
  State<WorkoutDurationScreen> createState() => _WorkoutDurationScreenState();
}

class _WorkoutDurationScreenState extends State<WorkoutDurationScreen> {
  // Workout duration options
  final List<Map<String, String>> durations = [
    {'title': 'Quick Boost', 'subtitle': '5–10 minutes'},
    {'title': 'Short & Effective', 'subtitle': '10–20 minutes'},
    {'title': 'Standard Session', 'subtitle': '20–30 minutes'},
    {'title': 'Focused Training', 'subtitle': '30–45 minutes'},
    {'title': 'Intense Workout', 'subtitle': '45–60 minutes'},
    {'title': 'Advanced Training', 'subtitle': '60–90 minutes'},
  ];

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        // Title removed per request; AppBar shows only the back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Centered header and subtitle; reduced extra top spacing
            Center(
              child: CustomText(
                text: 'Workout Preferences',
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: CustomText(
                text: 'How long can you work out per session?',
                fontSize: 14.0,
                color: Colors.grey,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 12),

            // List of duration options
            Expanded(
              child: ListView.builder(
                itemCount: durations.length,
                itemBuilder: (context, index) {
                  final duration = durations[index];
                  final isSelected = selectedIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0x1A282165)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF282165)
                              : Colors.grey.shade300,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                duration['title']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                duration['subtitle']!,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Icon(
                            isSelected
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off,
                            color: isSelected
                                ? const Color(0xFF282165)
                                : Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            Buttons(
              customTextTwo: 'Next',
              onTap: () async {
                if (selectedIndex != -1) {
                  final selectedDuration =
                      durations[selectedIndex]['subtitle'] ?? '';

                  Get.to(
                    () => AllSetScreen(
                      name: '',
                      gender: '',
                      age: '',
                      height: '',
                      weight: '',
                      fitnessGoal: widget.fitnessGoal ?? '',
                      activityLevel: widget.activityLevel ?? '',
                      workoutType: (widget.workoutTypes ?? []).join(', '),
                      workoutDuration: selectedDuration,
                      workoutFrequency: '',
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select your workout duration'),
                    ),
                  );
                }
                return;
              },
            ),
          ],
        ),
      ),
    );
  }
}
