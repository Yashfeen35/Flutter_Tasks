// import 'package:get/get.dart';
// import 'package:fitlife/data/Repo/AuthRepo.dart';
// import 'package:fitlife/ViewModel/auth/LoginVM.dart';
// import 'package:fitlife/ViewModel/auth/SignUpVM.dart';
//
// class InitialBindings extends Bindings {
//   @override
//   void dependencies() {
//     // Register a singleton AuthRepo
//     Get.put<AuthRepo>(AuthRepo());
//
//     // Register lazy instances of VMs that will use the AuthRepo
//     Get.lazyPut<LoginVM>(() => LoginVM());
//     Get.lazyPut<SignUpVM>(() => SignUpVM());
//   }
// }

import 'package:get/get.dart';
import 'package:fitlife/data/repo/meal_repo.dart'; // lowercase r
import 'package:fitlife/data/Repo/AuthRepo.dart';
import 'package:fitlife/ViewModel/auth/LoginVM.dart';
import 'package:fitlife/ViewModel/auth/SignUpVM.dart';
import 'package:fitlife/ViewModel/meal_view_model.dart';
import 'package:fitlife/data/repo/profile_repo.dart';
import 'package:fitlife/ViewModel/profile_view_model.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    // Auth
    Get.put<AuthRepo>(AuthRepo());
    Get.lazyPut<LoginVM>(() => LoginVM());
    Get.lazyPut<SignUpVM>(() => SignUpVM());

    // Meals
    Get.put<MealRepo>(MealRepo());
    Get.lazyPut<MealViewModel>(() => MealViewModel(Get.find<MealRepo>()));

    // Profile (image upload & profile state)
    Get.lazyPut<ProfileRepo>(() => ProfileRepo());
    Get.lazyPut<ProfileViewModel>(
      () => ProfileViewModel(Get.find<ProfileRepo>()),
    );
  }
}
