import "package:flutter/material.dart";
import "package:fitlife/components/text.dart";
import "package:fitlife/components/buttons.dart";
import 'package:get/get.dart';
import 'package:fitlife/routes.dart';

class PersonalInfoScreen extends StatefulWidget {
  static const String id = "personal_info_screen";

  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  String? selectedGender;
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  Widget label(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }

  Widget inputBox({required Widget child}) {
    return Container(
      height: 54.0,
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.grey.shade300, width: 1.0),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CustomText(
                text: "Personal Info",
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 50.0),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      label("Gender"),
                      const SizedBox(height: 6.0),
                      inputBox(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true, // ✅ FIXED overflow
                            value: selectedGender,
                            hint: Text(
                              "Select Gender",
                              style: TextStyle(
                                fontSize: 13.0,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            items: ["Male", "Female"].map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 14.0),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      label("Age"),
                      const SizedBox(height: 6.0),
                      inputBox(
                        child: TextField(
                          controller: ageController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Age",
                            hintStyle: TextStyle(
                              fontSize: 13.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16.0),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      label("Height (cm)"),
                      const SizedBox(height: 6.0),
                      inputBox(
                        child: TextField(
                          controller: heightController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "e.g. 170.5",
                            hintStyle: TextStyle(
                              fontSize: 13.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 14.0),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      label("Weight (kg)"),
                      const SizedBox(height: 6.0),
                      inputBox(
                        child: TextField(
                          controller: weightController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "e.g. 60.3",
                            hintStyle: TextStyle(
                              fontSize: 13.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const Spacer(),

            Buttons(
              customTextTwo: "Next",
              onTap: () async {
                Get.toNamed(Routes.fitnessGoal);
              },
            ),

            const SizedBox(height: 35.0),
          ],
        ),
      ),
    );
  }
}
