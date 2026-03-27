import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'add_food_screen.dart';
import 'components/bottom_nav.dart';
import 'components/color.dart';
import 'components/text.dart';
import 'components/buttons.dart';
import '../ViewModel/meal_view_model.dart';

class NutritionScreen extends GetView<MealViewModel> {
  const NutritionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool settingsTapped = false;
    bool notificationsTapped = false;

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, authSnap) {
        final user = authSnap.data;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              "Nutrition",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  notificationsTapped = !notificationsTapped;
                },
                icon: Icon(
                  Icons.notifications_outlined,
                  color: notificationsTapped
                      ? Theme.of(context).primaryColor
                      : Colors.grey.shade700,
                ),
              ),
              IconButton(
                onPressed: () {
                  settingsTapped = !settingsTapped;
                },
                icon: Icon(
                  Icons.settings_outlined,
                  color: settingsTapped
                      ? Theme.of(context).primaryColor
                      : Colors.grey.shade700,
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),

          body: user == null
              ? Center(
                  child: Text(
                    'Please sign in to view your meals.',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                )
              : Column(
                  children: [
                    const SizedBox(height: 10),

                    // ---------- DAILY SUMMARY ----------
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            CircularPercentIndicator(
                              radius: 60,
                              lineWidth: 12,
                              percent: 1450 / 2000,
                              progressColor: Theme.of(context).primaryColor,
                              backgroundColor: Colors.grey.shade200,
                              circularStrokeCap: CircularStrokeCap.round,
                              center: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "1,450",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "of 2,000 kcal",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                SummaryItem(
                                  title: "Consumed",
                                  value: "1,450 kcal",
                                ),
                                SummaryItem(
                                  title: "Daily Goal",
                                  value: "2,000 kcal",
                                ),
                                SummaryItem(
                                  title: "Remaining",
                                  value: "550 kcal",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ---------- ADD FOOD ----------
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            await Get.to(() => const AddFoodScreen());
                          },
                          child: const Text(
                            "Add Food",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ---------- MEAL LIST ----------
                    Expanded(
                      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: controller.mealsStreamForOwner(user.uid),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: Text(
                                'No meals yet.',
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            );
                          }

                          final docs = snapshot.data!.docs;

                          return ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemCount: docs.length,
                            itemBuilder: (context, index) {
                              final doc = docs[index];
                              final data = doc.data();

                              IconData iconData;
                              switch ((data['mealType'] ?? '')
                                  .toString()
                                  .toLowerCase()) {
                                case 'breakfast':
                                  iconData = Icons.free_breakfast_outlined;
                                  break;
                                case 'lunch':
                                  iconData = Icons.lunch_dining_outlined;
                                  break;
                                case 'dinner':
                                  iconData = Icons.dinner_dining_outlined;
                                  break;
                                default:
                                  iconData = Icons.fastfood_outlined;
                              }

                              return Container(
                                margin: const EdgeInsets.only(bottom: 14),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      iconData,
                                      size: 34,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${data['name'] ?? ''} (${data['calories']?.toString() ?? '—'} kcal)',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            data['mealType'] ?? '',
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.blue,
                                          ),
                                          onPressed: () async {
                                            await Get.to(
                                              () => AddFoodScreen(
                                                docId: doc.id,
                                                initialData: data,
                                              ),
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: () async {
                                            final confirmed =
                                                await showDialog<bool>(
                                                  context: context,
                                                  builder: (_) => AlertDialog(
                                                    title: const Text(
                                                      'Delete Meal?',
                                                    ),
                                                    content: const Text(
                                                      'Are you sure you want to delete this meal?',
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                              context,
                                                              false,
                                                            ),
                                                        child: const Text(
                                                          'Cancel',
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                              context,
                                                              true,
                                                            ),
                                                        child: const Text(
                                                          'Delete',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                            if (confirmed == true) {
                                              await controller.deleteMeal(
                                                doc.id,
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),

          bottomNavigationBar: const BottomNavBar(currentIndex: 2),
        );
      },
    );
  }
}

// ---------- SUMMARY ITEM ----------
class SummaryItem extends StatelessWidget {
  final String title;
  final String value;

  const SummaryItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ],
    );
  }
}
