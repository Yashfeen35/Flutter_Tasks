import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/repo/meal_repo.dart';

class MealViewModel extends GetxController {
  final MealRepo repo;

  MealViewModel(this.repo);

  // 🔹 Observable states
  final isLoading = false.obs;
  final error = RxnString();

  // Expose the stream for the UI (owner-specific)
  Stream<QuerySnapshot<Map<String, dynamic>>> mealsStreamForOwner(
    String ownerUid,
  ) {
    return repo.getMealsForOwner(ownerUid);
  }

  // 🔹 Add Meal
  Future<bool> addMeal(Map<String, dynamic> data) async {
    isLoading.value = true;
    error.value = null;

    try {
      final ok = await repo.addMeal(data);
      if (!ok) error.value = 'Failed to add meal';
      return ok;
    } catch (e) {
      error.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // 🔹 Update Meal
  Future<bool> updateMeal(String docId, Map<String, dynamic> data) async {
    isLoading.value = true;
    error.value = null;

    try {
      final ok = await repo.updateMeal(docId, data);
      if (!ok) error.value = 'Failed to update meal';
      return ok;
    } catch (e) {
      error.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // 🔹 Delete Meal
  Future<bool> deleteMeal(String docId) async {
    isLoading.value = true;
    error.value = null;

    try {
      final ok = await repo.deleteMeal(docId);
      if (!ok) error.value = 'Failed to delete meal';
      return ok;
    } catch (e) {
      error.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
