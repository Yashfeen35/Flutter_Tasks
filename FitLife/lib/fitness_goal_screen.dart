import 'package:flutter/material.dart';
import 'package:fitlife/components/text.dart';
import 'package:fitlife/components/buttons.dart';
import 'package:flutter/services.dart';
import 'package:fitlife/activity_level_screen.dart';
import 'package:get/get.dart';
import 'package:fitlife/routes.dart';

class FitnessGoalScreen extends StatefulWidget {
  static const String id = "fitness_goal_screen";

  const FitnessGoalScreen({super.key});

  @override
  State<FitnessGoalScreen> createState() => _FitnessGoalScreenState();
}

class _FitnessGoalScreenState extends State<FitnessGoalScreen> {
  final List<String> goals = [
    "Lose weight",
    "Maintain weight",
    "Build muscle",
    "Improve endurance",
    "Get flexible",
    "Improve overall health",
    "Increase Strength",
    "Gain Weight",
    "Become Athletic",
    "Tone Body",
  ];

  // Allow multiple selections
  final Set<String> selectedGoals = <String>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        // elevation: 0.0,
        // systemOverlayStyle: const SystemUiOverlayStyle(
        //   statusBarColor: Colors.white,
        //   statusBarIconBrightness: Brightness.dark,
        // ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.toNamed(Routes.personalInfo),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CustomText(
                text: "Fitness Goal",
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 30.0),

            Expanded(
              child: ListView.builder(
                itemCount: goals.length,
                itemBuilder: (context, index) {
                  String goal = goals[index];
                  bool isSelected = selectedGoals.contains(goal);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedGoals.remove(goal);
                        } else {
                          selectedGoals.add(goal);
                        }
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12.0),
                      padding: const EdgeInsets.symmetric(
                        vertical: 18.0,
                        horizontal: 14.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: isSelected
                            ? const Color(0xFFE7E1FF)
                            : Colors.white,
                        border: Border.all(
                          color: isSelected
                              ? Colors.deepPurple
                              : Colors.grey.shade300,
                          width: 1.4,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isSelected
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            color: isSelected ? Colors.deepPurple : Colors.grey,
                          ),
                          const SizedBox(width: 14.0),
                          CustomText(
                            text: goal,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            Buttons(
              customTextTwo: "Next",
              onTap: () async {
                if (selectedGoals.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please select at least one goal"),
                    ),
                  );

                  return;
                }

                // Pass the selected goals (joined) to ActivityLevelScreen
                final String joinedGoals = selectedGoals.join(', ');

                Get.to(() => ActivityLevelScreen(fitnessGoal: joinedGoals));
              },
            ),

            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}
