import 'package:get/get.dart';
import '../data/repo/meal_repo.dart';
import '../ViewModel/meal_view_model.dart';

class MealBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MealRepo>(MealRepo());
    Get.lazyPut<MealViewModel>(() => MealViewModel(Get.find<MealRepo>()));
  }
}
