import 'package:flutter/material.dart';
import 'components/buttons.dart';
import 'workout_duration_screen.dart';
import 'package:get/get.dart';

class WorkoutPreferencesScreen extends StatefulWidget {
  final String? fitnessGoal;
  final String? activityLevel;

  const WorkoutPreferencesScreen({
    super.key,
    this.fitnessGoal,
    this.activityLevel,
  });

  @override
  State<WorkoutPreferencesScreen> createState() =>
      _WorkoutPreferencesScreenState();
}

class _WorkoutPreferencesScreenState extends State<WorkoutPreferencesScreen> {
  // Workout preference options
  final List<Map<String, dynamic>> workoutOptions = [
    {'name': 'Cardio', 'icon': Icons.favorite, 'selected': false},
    {'name': 'Strength', 'icon': Icons.fitness_center, 'selected': false},
    {'name': 'Stretching', 'icon': Icons.accessibility_new, 'selected': false},
    {'name': 'HIIT', 'icon': Icons.flash_on, 'selected': false},
    {'name': 'Running', 'icon': Icons.directions_run, 'selected': false},
    {'name': 'Cycling', 'icon': Icons.pedal_bike, 'selected': false},
  ];

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
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: const Text(
                'Workout Preferences',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: const Text(
                'What kind of workouts do you like?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),

            // Grid of workout options
            Expanded(
              child: GridView.builder(
                itemCount: workoutOptions.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) {
                  final option = workoutOptions[index];
                  final isSelected = option['selected'];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        workoutOptions[index]['selected'] =
                            !workoutOptions[index]['selected'];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0x1A282165)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF282165)
                              : Colors.grey.shade300,
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            option['icon'],
                            size: 36,
                            color: isSelected
                                ? const Color(0xFF282165)
                                : Colors.black87,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            option['name'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? const Color(0xFF282165)
                                  : Colors.black,
                            ),
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
                final List<String> selectedWorkouts = workoutOptions
                    .where((opt) => opt['selected'])
                    .map<String>((opt) => opt['name'] as String)
                    .toList();

                if (selectedWorkouts.isNotEmpty) {
                  Get.to(
                    () => WorkoutDurationScreen(workoutTypes: selectedWorkouts),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select at least one workout type'),
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
