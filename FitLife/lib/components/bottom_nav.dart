import 'package:flutter/material.dart';
import '../homescreen.dart';
import '../workouts_screen.dart';
import '../nutrition_screen.dart';
import '../progress_screen.dart';
import '../profile_screen.dart';
import 'package:get/get.dart';
import 'package:fitlife/routes.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  const BottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: currentIndex,
      selectedItemColor: const Color(0xFF2D1E7C),
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        if (index == currentIndex) return; // no-op
        // Navigate to the selected tab route using centralized route names.
        switch (index) {
          case 0:
            Get.offAllNamed(Routes.home);
            break;
          case 1:
            Get.offAllNamed(Routes.workouts);
            break;
          case 2:
            Get.offAllNamed(Routes.nutrition);
            break;
          case 3:
            Get.offAllNamed(Routes.progress);
            break;
          case 4:
            Get.offAllNamed(Routes.profile);
            break;
          default:
            Get.offAllNamed(Routes.home);
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.fitness_center_rounded),
          label: 'Workouts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant_menu),
          label: 'Nutrition',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.show_chart),
          label: 'Progress',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
