import 'package:get/get.dart';
import 'package:fitlife/splash_screen.dart';
import 'package:fitlife/login_screen.dart';
import 'package:fitlife/sign_up.dart';
import 'package:fitlife/set_password_screen.dart';
import 'package:fitlife/success_screen.dart';
import 'package:fitlife/personal_info_screen.dart';
import 'package:fitlife/fitness_goal_screen.dart';
import 'package:fitlife/homescreen.dart';
import 'package:fitlife/onboarding_screens.dart';
import 'package:fitlife/workouts_screen.dart';
import 'package:fitlife/nutrition_screen.dart';
import 'package:fitlife/progress_screen.dart';
import 'package:fitlife/profile_screen.dart';

import 'package:fitlife/bindings/nutrition_binding.dart';
import 'package:fitlife/bindings/profile_binding.dart';

/// Centralized route definitions for GetX
class Routes {
  static const String splash = '/splash';
  static const String login = '/login_screen';
  static const String signup = '/signup_screen';
  static const String setPassword = '/set_password_screen';
  static const String success = '/success_screen';
  static const String personalInfo = '/personal_info_screen';
  static const String fitnessGoal = '/fitness_goal_screen';
  static const String home = '/home';
  static const String workouts = '/workouts';
  static const String nutrition = '/nutrition';
  static const String progress = '/progress';
  static const String profile = '/profile';
  static const String onboarding = '/onboarding';
}

/// AppPages will be used in main.dart to register GetPages.
class AppPages {
  static final List<GetPage> getPages = [
    GetPage(name: Routes.splash, page: () => const SplashScreen()),

    GetPage(name: Routes.login, page: () => const LoginScreen()),

    GetPage(name: Routes.signup, page: () => const SignUpScreen()),

    GetPage(name: Routes.setPassword, page: () => const SetPasswordScreen()),

    GetPage(name: Routes.success, page: () => const SuccessScreen()),

    GetPage(name: Routes.personalInfo, page: () => const PersonalInfoScreen()),

    GetPage(name: Routes.fitnessGoal, page: () => const FitnessGoalScreen()),

    GetPage(name: Routes.onboarding, page: () => const OnboardingScreen()),

    GetPage(
      name: Routes.home,
      page: () => HomeScreen(),
      binding: ProfileBinding(),
    ),

    GetPage(name: Routes.workouts, page: () => const WorkoutScreen()),

    // 🔥 FIXED NUTRITION ROUTE (IMPORTANT)
    GetPage(
      name: Routes.nutrition,
      page: () => const NutritionScreen(),
      binding: NutritionBinding(),
    ),

    GetPage(name: Routes.progress, page: () => const ProgressScreen()),

    GetPage(name: Routes.profile, page: () => const ProfileScreen()),
  ];
}
