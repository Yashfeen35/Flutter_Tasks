import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitlife/data/repo/meal_repo.dart';
import 'package:fitlife/ViewModel/meal_view_model.dart';

class NutritionBinding extends Bindings {
  @override
  void dependencies() {
    // Register Firestore (created when first requested)
    Get.lazyPut<FirebaseFirestore>(() => FirebaseFirestore.instance);

    // Register Repository lazily so it's created only when needed
    Get.lazyPut<MealRepo>(() => MealRepo());

    // Register ViewModel lazily and resolve its MealRepo dependency
    Get.lazyPut<MealViewModel>(() => MealViewModel(Get.find<MealRepo>()));
  }
}
