import 'package:flutter/material.dart';
import 'package:fitlife/workout_prefernces_screen.dart';
import 'package:fitlife/components/buttons.dart';
import 'package:fitlife/components/text.dart';
import 'package:get/get.dart';

class ActivityLevelScreen extends StatefulWidget {
  static const String id = "Activity_Level_Screen";
  final String? fitnessGoal;
  const ActivityLevelScreen({super.key, this.fitnessGoal});

  @override
  State<ActivityLevelScreen> createState() => _ActivityLevelScreenState();
}

class _ActivityLevelScreenState extends State<ActivityLevelScreen> {
  // Activity level options
  final List<Map<String, String>> activityLevels = [
    {
      'title': 'Sedentary',
      'subtitle': 'Mostly sitting (e.g., desk job)',
      'icon': '💺',
    },
    {
      'title': 'Lightly active',
      'subtitle': 'Light daily activity (e.g., short walks)',
      'icon': '🚶‍♀️',
    },
    {
      'title': 'Moderately active',
      'subtitle': 'Regular workouts (2–3 times/week)',
      'icon': '🏋️‍♂️',
    },
    {
      'title': 'Very active',
      'subtitle': 'Daily workouts or physical job',
      'icon': '🤸‍♀️',
    },
    {
      'title': 'Extremely active',
      'subtitle': 'Athlete-level training',
      'icon': '🏅',
    },
  ];

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(23.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CustomText(
                text: 'Activity Level',
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),

            // List of activity options
            Expanded(
              child: ListView.builder(
                itemCount: activityLevels.length,
                itemBuilder: (context, index) {
                  final level = activityLevels[index];
                  final isSelected = selectedIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0x1A282165)
                            : Colors.white,
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF282165)
                              : Colors.grey.shade300,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Text(
                            level['icon']!,
                            style: const TextStyle(fontSize: 26),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  level['title']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  level['subtitle']!,
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            isSelected
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off,
                            color: isSelected
                                ? const Color(0xFF282165)
                                : Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            Buttons(
              customTextTwo: 'Next',
              onTap: () async {
                if (selectedIndex != -1) {
                  final selectedLevel =
                      activityLevels[selectedIndex]['title'] ?? '';
                  Get.to(
                    () => WorkoutPreferencesScreen(
                      fitnessGoal: widget.fitnessGoal ?? '',
                      activityLevel: selectedLevel,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select your activity level'),
                    ),
                  );
                }
                return;
              },
            ),
          ],
        ),
      ),
    );
  }
}

// import 'dart:io';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:crypto/crypto.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloudinary_public/cloudinary_public.dart';
//
// /// Repository responsible for uploading profile images to Cloudinary
// /// and saving the URL to Firestore.
// class ProfileRepo {
//   final FirebaseFirestore firestore;
//
//   ProfileRepo({FirebaseFirestore? firestore})
//       : firestore = firestore ?? FirebaseFirestore.instance;
//
//   // Current user's UID
//   String? get _uid => FirebaseAuth.instance.currentUser?.uid;
//
//   // Firestore document reference for the current user
//   DocumentReference<Map<String, dynamic>>? get _docRef =>
//       _uid != null ? firestore.collection('profiles').doc(_uid) : null;
//
//   /// Stream the profile document for real-time updates
//   Stream<DocumentSnapshot<Map<String, dynamic>>> streamProfile() {
//     final ref = _docRef;
//     if (ref == null) return const Stream.empty();
//     return ref.snapshots();
//   }
//
//   /// Save uploaded image URL to Firestore
//   Future<void> saveImageUrl(String url) async {
//     final ref = _docRef;
//     if (ref == null) throw StateError('No signed-in user.');
//     await ref.set({
//       'imageUrl': url,
//       'updatedAt': FieldValue.serverTimestamp(),
//     }, SetOptions(merge: true));
//   }
//
//   // Cloudinary configuration
//   static const _cloudName = 'dim90cfvr';
//   static const String? _unsignedUploadPreset =
//   null; // e.g. 'unsigned_preset_name'
//   static const _apiKey = '867454332433977';
//   static const _apiSecret = 'lbfgs-_a4ZAv289wmLu_tZtTpzc';
//
//   /// Upload file to Cloudinary using unsigned preset
//   /// Returns secure URL on success, null on failure
//   Future<String?> uploadProfile(File file) async {
//     try {
//       // 1) Try unsigned upload if preset configured
//       if (_unsignedUploadPreset != null && _unsignedUploadPreset!.isNotEmpty) {
//         try {
//           final cloudinary = CloudinaryPublic(
//             _cloudName,
//             _unsignedUploadPreset!,
//             cache: false,
//           );
//           final response = await cloudinary.uploadFile(
//             CloudinaryFile.fromFile(
//               file.path,
//               resourceType: CloudinaryResourceType.Image,
//             ),
//           );
//           print(
//             '[ProfileRepo] Cloudinary (unsigned) upload succeeded: ${response.secureUrl}',
//           );
//           return response.secureUrl;
//         } catch (e, st) {
//           // Log and continue to fallback signed upload
//           print('[ProfileRepo] Cloudinary (unsigned) upload error: $e');
//           print('[ProfileRepo] Falling back to signed HTTP upload.');
//         }
//       }
//
//       // 2) Signed HTTP upload (fallback)
//       final uri = Uri.parse(
//         'https://api.cloudinary.com/v1_1/dim90cfvr/image/upload',
//       );
//       final timestamp = (DateTime.now().millisecondsSinceEpoch ~/ 1000)
//           .toString();
//
//       // Create signature: sha1 of "timestamp=<timestamp><api_secret>"
//       final signatureInput = 'timestamp=$timestamp$_apiSecret';
//       final signature = sha1.convert(utf8.encode(signatureInput)).toString();
//
//       final request = http.MultipartRequest('POST', uri)
//         ..fields['api_key'] = _apiKey
//         ..fields['timestamp'] = timestamp
//         ..fields['signature'] = signature
//         ..files.add(await http.MultipartFile.fromPath('file', file.path));
//
//       final streamed = await request.send();
//       final resp = await http.Response.fromStream(streamed);
//
//       if (resp.statusCode >= 200 && resp.statusCode < 300) {
//         final Map<String, dynamic> body = json.decode(resp.body);
//         final secureUrl = body['secure_url'] as String?;
//         print('[ProfileRepo] Cloudinary (signed) upload succeeded: $secureUrl');
//         return secureUrl;
//       }
//
//       // non-2xx
//       print(
//         '[ProfileRepo] Cloudinary upload failed: ${resp.statusCode} ${resp.body}',
//       );
//       return null;
//     } catch (e, st) {
//       print('[ProfileRepo] uploadProfile error: $e\n$st');
//       return null;
//     }
//   }
//
//   /// Convenience method: upload file and save URL to Firestore
//   Future<void> uploadAndSave(File file) async {
//     final url = await uploadProfile(file);
//     if (url != null) await saveImageUrl(url);
//   }
// }

// vm
// import 'dart:async';
// import 'dart:io';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../data/repo/profile_repo.dart';
//
// class ProfileViewModel extends GetxController {
//   final ProfileRepo repo;
//   ProfileViewModel(this.repo);
//
//   final RxnString imageUrl = RxnString(); // nullable observable
//   final RxBool isUploading = false.obs;
//   final RxnString error = RxnString();
//
//   StreamSubscription? _sub;
//   StreamSubscription<User?>? _authSub;
//
//   @override
//   void onInit() {
//     super.onInit();
//
//     // Listen to auth state changes
//     _authSub = FirebaseAuth.instance.authStateChanges().listen((user) {
//       _sub?.cancel();
//       _sub = null;
//
//       if (user == null) {
//         imageUrl.value = null;
//       } else {
//         _sub = repo.streamProfile().listen((snapshot) {
//           final url = snapshot.data()?['imageUrl'] as String?;
//           imageUrl.value = url;
//         }, onError: (e) => error.value = e.toString());
//       }
//     });
//   }
//
//   @override
//   void onClose() {
//     _sub?.cancel();
//     _authSub?.cancel();
//     super.onClose();
//   }
//
//   /// Picks an image, uploads to Cloudinary, saves URL to Firestore,
//   /// and updates [imageUrl]. Errors stored in [error].
//   Future<void> pickAndUpload(ImageSource source) async {
//     try {
//       error.value = null;
//
//       final user = FirebaseAuth.instance.currentUser;
//       if (user == null) {
//         error.value = 'Please sign in to update your profile.';
//         return;
//       }
//
//       final picker = ImagePicker();
//       final picked = await picker.pickImage(source: source, imageQuality: 80);
//       if (picked == null) return;
//
//       final file = File(picked.path);
//       isUploading.value = true;
//
//       final uploadedUrl = await repo.uploadProfile(file);
//       if (uploadedUrl == null) {
//         error.value = 'Image upload failed.';
//         return;
//       }
//
//       imageUrl.value = uploadedUrl;
//
//       try {
//         await repo.saveImageUrl(uploadedUrl);
//       } catch (e) {
//         error.value = 'Uploaded but failed to save to Firestore: $e';
//         print('[ProfileViewModel] saveImageUrl error: $e');
//       }
//     } catch (e, st) {
//       error.value = e.toString();
//       print('[ProfileViewModel] pickAndUpload error: $e\n$st');
//     } finally {
//       isUploading.value = false;
//     }
//   }
// }
