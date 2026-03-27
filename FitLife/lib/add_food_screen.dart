// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../data/repo/meal_repo.dart';
// import '../ViewModel/meal_view_model.dart';
// import 'components/text.dart';
// import 'components/textform.dart';
// import 'components/buttons.dart';
// import 'components/color.dart';
//
// class AddFoodScreen extends StatefulWidget {
//   // If docId is provided, the screen will operate in edit mode
//   final String? docId;
//   final Map<String, dynamic>? initialData;
//
//   const AddFoodScreen({Key? key, this.docId, this.initialData})
//     : super(key: key);
//
//   @override
//   State<AddFoodScreen> createState() => _AddFoodScreenState();
// }
//
// class _AddFoodScreenState extends State<AddFoodScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String _mealType = 'Breakfast';
//   final TextEditingController _mealNameController = TextEditingController();
//   final TextEditingController _caloriesController = TextEditingController();
//   bool _isSaving = false;
//
//   bool get isEditMode => widget.docId != null;
//
//   @override
//   void initState() {
//     super.initState();
//     // Prefill if editing
//     final data = widget.initialData;
//     if (data != null) {
//       _mealType = (data['mealType'] ?? _mealType) as String;
//       _mealNameController.text = (data['name'] ?? '') as String;
//       _caloriesController.text = (data['calories']?.toString() ?? '');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.backgroundColor,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: CustomText(
//                     text: isEditMode ? 'Edit Food' : 'Add Food',
//                     fontSize: 24.0,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const SizedBox(height: 30.0),
//                 CustomText(
//                   text: 'Meal Type',
//                   fontSize: 14.0,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//                 const SizedBox(height: 8.0),
//                 DropdownButtonFormField<String>(
//                   value: _mealType,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.grey.shade200,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                   ),
//                   items: const [
//                     DropdownMenuItem(
//                       value: 'Breakfast',
//                       child: Text('Breakfast'),
//                     ),
//                     DropdownMenuItem(value: 'Lunch', child: Text('Lunch')),
//                     DropdownMenuItem(value: 'Dinner', child: Text('Dinner')),
//                   ],
//                   onChanged: (v) {
//                     if (v == null) return;
//                     setState(() => _mealType = v);
//                   },
//                 ),
//                 const SizedBox(height: 20.0),
//                 CustomText(
//                   text: 'Meal Name',
//                   fontSize: 14.0,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//                 const SizedBox(height: 8.0),
//                 CustomTextFormField(
//                   controller: _mealNameController,
//                   keyboard: TextInputType.text,
//                   hintText: 'Enter meal name',
//                 ),
//                 const SizedBox(height: 20.0),
//                 CustomText(
//                   text: 'Calories',
//                   fontSize: 14.0,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//                 const SizedBox(height: 8.0),
//                 CustomTextFormField(
//                   controller: _caloriesController,
//                   keyboard: TextInputType.number,
//                   hintText: 'Enter calories',
//                 ),
//                 const SizedBox(height: 28.0),
//                 Buttons(
//                   customTextTwo: _isSaving
//                       ? 'Saving...'
//                       : isEditMode
//                       ? 'Update Food'
//                       : 'Add Food',
//                   onTap: () async {
//                     if (_isSaving) return;
//
//                     final name = _mealNameController.text.trim();
//                     final caloriesText = _caloriesController.text.trim();
//
//                     if (name.isEmpty) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('Please enter meal name')),
//                       );
//                       return;
//                     }
//
//                     final calories = int.tryParse(caloriesText);
//                     if (caloriesText.isEmpty ||
//                         calories == null ||
//                         calories < 0) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('Please enter valid calories'),
//                         ),
//                       );
//                       return;
//                     }
//
//                     final user = FirebaseAuth.instance.currentUser;
//                     if (user == null) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text(
//                             'You must be signed in to add or edit meals',
//                           ),
//                         ),
//                       );
//                       return;
//                     }
//
//                     setState(() => _isSaving = true);
//
//                     final repo = MealRepo();
//                     final vm = MealViewModel(repo);
//                     bool ok = false;
//
//                     if (isEditMode) {
//                       ok = await vm.updateMeal(widget.docId!, {
//                         'name': name,
//                         'mealType': _mealType,
//                         'calories': calories,
//                         'subtitle': '',
//                       });
//                     } else {
//                       ok = await vm.addMeal({
//                         'name': name,
//                         'mealType': _mealType,
//                         'calories': calories,
//                         'ownerUid': user.uid,
//                         'createdAt': FieldValue.serverTimestamp(),
//                         'subtitle': '',
//                       });
//                     }
//
//                     if (ok) {
//                       Navigator.pop(context);
//                     } else {
//                       setState(() => _isSaving = false);
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text(vm.error ?? 'Failed to save meal'),
//                         ),
//                       );
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _mealNameController.dispose();
//     _caloriesController.dispose();
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../ViewModel/meal_view_model.dart';
import 'components/text.dart';
import 'components/textform.dart';
import 'components/buttons.dart';
import 'components/color.dart';
import 'package:get/get.dart';

class AddFoodScreen extends StatefulWidget {
  final String? docId;
  final Map<String, dynamic>? initialData;

  const AddFoodScreen({Key? key, this.docId, this.initialData})
    : super(key: key);

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  final _formKey = GlobalKey<FormState>();
  String _mealType = 'Breakfast';
  final TextEditingController _mealNameController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  bool _isSaving = false;

  bool get isEditMode => widget.docId != null;

  // ✅ Get MealViewModel from GetX
  final MealViewModel vm = Get.find<MealViewModel>();

  @override
  void initState() {
    super.initState();
    final data = widget.initialData;
    if (data != null) {
      _mealType = (data['mealType'] ?? _mealType) as String;
      _mealNameController.text = (data['name'] ?? '') as String;
      _caloriesController.text = (data['calories']?.toString() ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CustomText(
                    text: isEditMode ? 'Edit Food' : 'Add Food',
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 30.0),
                CustomText(
                  text: 'Meal Type',
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                const SizedBox(height: 8.0),
                DropdownButtonFormField<String>(
                  value: _mealType,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Breakfast',
                      child: Text('Breakfast'),
                    ),
                    DropdownMenuItem(value: 'Lunch', child: Text('Lunch')),
                    DropdownMenuItem(value: 'Dinner', child: Text('Dinner')),
                  ],
                  onChanged: (v) {
                    if (v == null) return;
                    setState(() => _mealType = v);
                  },
                ),
                const SizedBox(height: 20.0),
                CustomText(
                  text: 'Meal Name',
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                const SizedBox(height: 8.0),
                CustomTextFormField(
                  controller: _mealNameController,
                  keyboard: TextInputType.text,
                  hintText: 'Enter meal name',
                ),
                const SizedBox(height: 20.0),
                CustomText(
                  text: 'Calories',
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                const SizedBox(height: 8.0),
                CustomTextFormField(
                  controller: _caloriesController,
                  keyboard: TextInputType.number,
                  hintText: 'Enter calories',
                ),
                const SizedBox(height: 28.0),
                Buttons(
                  customTextTwo: _isSaving
                      ? 'Saving...'
                      : isEditMode
                      ? 'Update Food'
                      : 'Add Food',
                  onTap: () async {
                    if (_isSaving) return;

                    final name = _mealNameController.text.trim();
                    final caloriesText = _caloriesController.text.trim();

                    if (name.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter meal name')),
                      );
                      return;
                    }

                    final calories = int.tryParse(caloriesText);
                    if (caloriesText.isEmpty ||
                        calories == null ||
                        calories < 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter valid calories'),
                        ),
                      );
                      return;
                    }

                    final user = FirebaseAuth.instance.currentUser;
                    if (user == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'You must be signed in to add or edit meals',
                          ),
                        ),
                      );
                      return;
                    }

                    setState(() => _isSaving = true);

                    bool ok = false;

                    if (isEditMode) {
                      ok = await vm.updateMeal(widget.docId!, {
                        'name': name,
                        'mealType': _mealType,
                        'calories': calories,
                        'subtitle': '',
                      });
                    } else {
                      ok = await vm.addMeal({
                        'name': name,
                        'mealType': _mealType,
                        'calories': calories,
                        'ownerUid': user.uid,
                        'createdAt': FieldValue.serverTimestamp(),
                        'subtitle': '',
                      });
                    }

                    if (ok) {
                      Navigator.pop(context);
                    } else {
                      setState(() => _isSaving = false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            vm.error.value ?? 'Failed to save meal',
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mealNameController.dispose();
    _caloriesController.dispose();
    super.dispose();
  }
}
