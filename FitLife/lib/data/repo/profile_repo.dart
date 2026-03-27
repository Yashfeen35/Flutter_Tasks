import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

/// Repository responsible for uploading profile images to Cloudinary
/// and saving the URL to Firestore.
class ProfileRepo {
  final FirebaseFirestore firestore;

  ProfileRepo({FirebaseFirestore? firestore})
    : firestore = firestore ?? FirebaseFirestore.instance;

  // Current user's UID
  String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  // Firestore document reference for the current user
  DocumentReference<Map<String, dynamic>>? get _docRef =>
      _uid != null ? firestore.collection('profiles').doc(_uid) : null;

  /// Stream the profile document for real-time updates
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamProfile() {
    final ref = _docRef;
    if (ref == null) return const Stream.empty();
    return ref.snapshots();
  }

  /// Save uploaded image URL to Firestore
  Future<void> saveImageUrl(String url) async {
    final ref = _docRef;
    if (ref == null) throw StateError('No signed-in user.');
    await ref.set({
      'imageUrl': url,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // Cloudinary configuration
  static const _cloudName = 'dim90cfvr';
  static const String? _unsignedUploadPreset =
      null; // e.g. 'unsigned_preset_name'
  static const _apiKey = '867454332433977';
  static const _apiSecret = 'lbfgs-_a4ZAv289wmLu_tZtTpzc';

  /// Upload file to Cloudinary using unsigned preset
  /// Returns secure URL on success, null on failure
  Future<String?> uploadProfile(File file) async {
    try {
      // 1) Try unsigned upload if preset configured
      if (_unsignedUploadPreset != null && _unsignedUploadPreset!.isNotEmpty) {
        try {
          final cloudinary = CloudinaryPublic(
            _cloudName,
            _unsignedUploadPreset!,
            cache: false,
          );
          final response = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(
              file.path,
              resourceType: CloudinaryResourceType.Image,
            ),
          );
          print(
            '[ProfileRepo] Cloudinary (unsigned) upload succeeded: ${response.secureUrl}',
          );
          return response.secureUrl;
        } catch (e, st) {
          // Log and continue to fallback signed upload
          print('[ProfileRepo] Cloudinary (unsigned) upload error: $e');
          print('[ProfileRepo] Falling back to signed HTTP upload.');
        }
      }

      // 2) Signed HTTP upload (fallback)
      final uri = Uri.parse(
        'https://api.cloudinary.com/v1_1/<cloud_name>/image/upload',
      );
      final timestamp = (DateTime.now().millisecondsSinceEpoch ~/ 1000)
          .toString();

      // Create signature: sha1 of "timestamp=<timestamp><api_secret>"
      final signatureInput = 'timestamp=$timestamp$_apiSecret';
      final signature = sha1.convert(utf8.encode(signatureInput)).toString();

      final request = http.MultipartRequest('POST', uri)
        ..fields['api_key'] = _apiKey
        ..fields['timestamp'] = timestamp
        ..fields['signature'] = signature
        ..files.add(await http.MultipartFile.fromPath('file', file.path));

      final streamed = await request.send();
      final resp = await http.Response.fromStream(streamed);

      if (resp.statusCode >= 200 && resp.statusCode < 300) {
        final Map<String, dynamic> body = json.decode(resp.body);
        final secureUrl = body['secure_url'] as String?;
        print('[ProfileRepo] Cloudinary (signed) upload succeeded: $secureUrl');
        return secureUrl;
      }

      // non-2xx
      print(
        '[ProfileRepo] Cloudinary upload failed: ${resp.statusCode} ${resp.body}',
      );
      return null;
    } catch (e, st) {
      print('[ProfileRepo] uploadProfile error: $e\n$st');
      return null;
    }
  }

  /// Convenience method: upload file and save URL to Firestore
  Future<void> uploadAndSave(File file) async {
    final url = await uploadProfile(file);
    if (url != null) await saveImageUrl(url);
  }
}
