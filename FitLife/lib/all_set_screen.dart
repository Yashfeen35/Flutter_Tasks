import 'package:flutter/material.dart';
import 'components/text.dart';
import 'components/buttons.dart';
import 'homescreen.dart';

class AllSetScreen extends StatelessWidget {
  final String name;
  final String gender;
  final String age;
  final String height;
  final String weight;
  final String fitnessGoal;
  final String activityLevel;
  final String workoutType;
  final String workoutDuration;
  final String workoutFrequency;

  const AllSetScreen({
    super.key,
    required this.name,
    required this.gender,
    required this.age,
    required this.height,
    required this.weight,
    required this.fitnessGoal,
    required this.activityLevel,
    required this.workoutType,
    required this.workoutDuration,
    required this.workoutFrequency,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CustomText(
                  text: "You're All Set",
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _infoTile(
                        title: name.isNotEmpty ? name : 'Name',
                        value:
                            "$gender • $age years old • $height cm • $weight kg",
                      ),

                      const SizedBox(height: 10),

                      _infoTile(
                        title: "Fitness Goals",
                        value: fitnessGoal.isNotEmpty ? fitnessGoal : '-',
                      ),
                      _infoTile(
                        title: "Activity Level",
                        value: activityLevel.isNotEmpty ? activityLevel : '-',
                      ),
                      _infoTile(
                        title: "Workout Type",
                        value: workoutType.isNotEmpty ? workoutType : '-',
                      ),
                      _infoTile(
                        title: "Workout Duration",
                        value: workoutDuration.isNotEmpty
                            ? workoutDuration
                            : '-',
                      ),
                      _infoTile(
                        title: "Workout Frequency",
                        value: workoutFrequency.isNotEmpty
                            ? workoutFrequency
                            : '-',
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 8),

              SizedBox(
                width: double.infinity,
                child: Buttons(
                  customTextTwo: 'Done',
                  onTap: () async {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => HomeScreen(name: name)),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoTile({required String title, required String value}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }
}
