import 'package:cloud_firestore/cloud_firestore.dart';

class MealRepo {
  final CollectionReference<Map<String, dynamic>> _mealsCollection =
      FirebaseFirestore.instance.collection('meals');

  // 🔹 Create
  Future<bool> addMeal(Map<String, dynamic> data) async {
    try {
      await _mealsCollection.add({
        ...data,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return true;
    } on FirebaseException catch (e) {
      print('[MealRepo] addMeal error: ${e.message}');
      return false;
    }
  }

  // 🔹 Update
  Future<bool> updateMeal(String docId, Map<String, dynamic> data) async {
    try {
      await _mealsCollection.doc(docId).update(data);
      return true;
    } on FirebaseException catch (e) {
      print('[MealRepo] updateMeal error: ${e.message}');
      return false;
    }
  }

  // 🔹 Delete
  Future<bool> deleteMeal(String docId) async {
    try {
      await _mealsCollection.doc(docId).delete();
      return true;
    } on FirebaseException catch (e) {
      print('[MealRepo] deleteMeal error: ${e.message}');
      return false;
    }
  }

  // 🔹 Read (Stream for real-time updates)
  Stream<QuerySnapshot<Map<String, dynamic>>> getMeals() {
    return _mealsCollection.orderBy('createdAt', descending: true).snapshots();
  }

  // 🔹 Read meals for a specific owner (useful for per-user lists)
  Stream<QuerySnapshot<Map<String, dynamic>>> getMealsForOwner(
    String ownerUid,
  ) {
    return _mealsCollection
        .where('ownerUid', isEqualTo: ownerUid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
